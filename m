Return-Path: <linux-fsdevel+bounces-35389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DE9D4874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E34B21BC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909B1C9B8C;
	Thu, 21 Nov 2024 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iojp8BbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9A17741;
	Thu, 21 Nov 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176337; cv=none; b=bGV4PmFzmpcjG0sceW6/AU6IfcxL+RBUlgiCQlX7RzvSEvgfCSL6TJ8vAyYD5EgyXMILahRZlFZj6d4FjndjuW0mtqqZSkBUyQxAAeEaR+grIwQ+LmLPMhrXSwKG2zTsPTUPBEByiJG9Uz9xNHCJpGj4d5PpYG11IpUpGbZVJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176337; c=relaxed/simple;
	bh=Ul911guu0KR7O8S+RynJYUwKY5jrJfJqp7uENsPvlj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PniscN0OSfXiS+s2nKBNodEJVW357pw3LqleyLoqAaNK/k7KkIH+/maYzZIL2kLTPej8JJGEmxVx/SFzIlttKHO0pYIiF9w0og2QE6O29MRtGNflxiwsLb/4cIehTVDhDOT6j5OE0FEMhHe0kDCqBHYgurAzxdym4xviNSAQ+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iojp8BbR; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-211fb27cc6bso5906765ad.0;
        Thu, 21 Nov 2024 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732176335; x=1732781135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tafgiYqdsdEg414sNws+fvvKwIofMiwq0yO24s8rGAc=;
        b=Iojp8BbRzQcAtlzzCQhSZAhuOyQxh48j+vqaVaboLRXuQnYiy15NBmtFIczpFZ876o
         HGn+DI5dGELF3bbaaCmiGYbj/fos7IHjDTCw0yV2RoAccdX6ODR6mP303kktgaoh5Brf
         T1qsCQ3kzLbqMeFn5r0RtuWDnbiEwqem2rs5um/R14R09g2DJl1eGLA3AyQ80K1pBBy2
         P8jk5KHqu5S7x5vgW0NKh706tAMHpblpM+JJwC4Q11a/hGrVbAp05OmXzkvP3YD4wQoE
         XGIdmqaIzYlPWsGRO9IJ1LxWrXSXjgkgSXzi0o9+dkR4iGo0W6qmU2lrExtfMZn1Z+eA
         HBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176335; x=1732781135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tafgiYqdsdEg414sNws+fvvKwIofMiwq0yO24s8rGAc=;
        b=qbfMaOX/7zcWwmKA7Ngh04JaOUrZViBbSrMq5g/QyF9uGLjSy+IlYix37xmhlwaVCX
         djXdxCQLgc7/gxvv6BUfWnoAFKC9eCkA78B2xK/0u8DWfvoxcoz2SfRExEzbYv3ESwFq
         XtxYV78h/yKQQAp7X897fI52QUCLboANCs+VwS74g4+oVBnsrzhnQ1zIn38KuI+1cHsl
         p9bLuQsTn3qO64Qx1Erg6ilC/embce7JDHuJPmrR8YY26O/TaT2uPEy/8ForvAk7atDB
         evDw0NYn1EsGVcRQq5Zevg806uNn114DrbLRLm8INiP9k0Bz9EZ8DWNXfWAb2cxGYpcY
         yG+w==
X-Forwarded-Encrypted: i=1; AJvYcCUFetMmf8IdHOTprTJQ301g8uNH90VWtrLLWZfHJ4q5xeE77cHK5qcd3P/mv35+NUFoNp+bKBTJmAld2j3X@vger.kernel.org, AJvYcCWnJ9FCUs/t8hwVVRV871BrZHZzTMBEcVm8w6iVDj9ui0Mc8yG9oPLm11L87V4kAj7DPciShQXaJhUrxCC1@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9Blls4Rwrgwvb4y9m3/0SRDiVFrhHTskRMzv/567nn8CUuud
	6ieoUCduJAozamioLu3mJmMxiUlFZHrgT8ymSju3CFX50wrB8u+WHUjbLQnN
X-Google-Smtp-Source: AGHT+IEundj1fBaIrCS/+c0DHO6GRi2BRtxwd+x+6wAEjNQxO3qXioRxcpWY6xs4ftw+vqvm9k3KXw==
X-Received: by 2002:a17:902:da90:b0:211:efa9:a4e6 with SMTP id d9443c01a7336-2126caa41c8mr61422165ad.23.1732176334835;
        Thu, 21 Nov 2024 00:05:34 -0800 (PST)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883fd550sm7691145ad.254.2024.11.21.00.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:05:34 -0800 (PST)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: shikemeng@huaweicloud.com
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH v2] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Thu, 21 Nov 2024 16:05:31 +0800
Message-Id: <20241121080531.567995-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5584d4d5-73c8-2a12-f11e-6f19c216656b@huaweicloud.com>
References: <5584d4d5-73c8-2a12-f11e-6f19c216656b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> on 11/19/2024 8:29 PM, Jim Zhao wrote:
> > Thanks, Jan, I just sent patch v2, could you please review it ?
> >
> > And I found the debug info in the bdi stats.
> > The BdiDirtyThresh value may be greater than DirtyThresh, and after applying this patch, the value of BdiDirtyThresh could become even larger.
> >
> > without patch:
> > ---
> > root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> > BdiWriteback:                0 kB
> > BdiReclaimable:             96 kB
> > BdiDirtyThresh:        1346824 kB
> > DirtyThresh:            673412 kB
> > BackgroundThresh:       336292 kB
> > BdiDirtied:              19872 kB
> > BdiWritten:              19776 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> >
> > with patch:
> > ---
> > root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> > BdiWriteback:               96 kB
> > BdiReclaimable:            192 kB
> > BdiDirtyThresh:        3090736 kB
> > DirtyThresh:            650716 kB
> > BackgroundThresh:       324960 kB
> > BdiDirtied:             472512 kB
> > BdiWritten:             470592 kB
> > BdiWriteBandwidth:      106268 kBps
> > b_dirty:                     2
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> >
> >
> > @kemeng, is this a normal behavior or an issue ?
> Hello, this is not a normal behavior, could you aslo send the content in
> wb_stats and configuired bdi_min_ratio.
> I think the improper use of bdi_min_ratio may cause the issue.

the min_ratio is 0
---
root@ubuntu:/sys/class/bdi/8:0# cat min_bytes
0
root@ubuntu:/sys/class/bdi/8:0# cat min_ratio
0
root@ubuntu:/sys/class/bdi/8:0# cat min_ratio_fine
0

wb_stats:
---

root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
BdiWriteback:                0 kB
BdiReclaimable:            480 kB
BdiDirtyThresh:        1664700 kB
DirtyThresh:            554900 kB
BackgroundThresh:       277108 kB
BdiDirtied:              82752 kB
BdiWritten:              82752 kB
BdiWriteBandwidth:      205116 kBps
b_dirty:                     6
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
root@ubuntu:/sys/kernel/debug/bdi/8:0# cat wb_stats
WbCgIno:                    1
WbWriteback:                0 kB
WbReclaimable:             96 kB
WbDirtyThresh:              0 kB
WbDirtied:              33600 kB
WbWritten:              33600 kB
WbWriteBandwidth:         148 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                  416
WbWriteback:                0 kB
WbReclaimable:            288 kB
WbDirtyThresh:         554836 kB
WbDirtied:              47616 kB
WbWritten:              47424 kB
WbWriteBandwidth:         168 kBps
b_dirty:                    1
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      5

WbCgIno:                 1319
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 1835
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                   29
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      101752 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                  158
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      101756 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 2498
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 3358
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 3573
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 3659
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 3186
WbWriteback:                0 kB
WbReclaimable:             96 kB
WbDirtyThresh:         554788 kB
WbDirtied:               1056 kB
WbWritten:               1152 kB
WbWriteBandwidth:         152 kBps
b_dirty:                    1
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      5

WbCgIno:                 3315
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                384 kB
WbWritten:                384 kB
WbWriteBandwidth:       98876 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                   72
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:         554836 kB
WbDirtied:                 96 kB
WbWritten:                192 kB
WbWriteBandwidth:           4 kBps
b_dirty:                    1
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      5

WbCgIno:                 3616
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      100308 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 4132
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 3401
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 4517
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 4846
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 4982
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      100468 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 5369
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                 96 kB
WbWriteBandwidth:       75104 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 5627
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 6235
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 6192
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 6500
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 4617
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 6958
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 5670
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    1
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      5

WbCgIno:                 5870
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 5025
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 7990
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:       91500 kBps
b_dirty:                    1
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      5

WbCgIno:                 8033
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                 2842
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

WbCgIno:                11129
WbWriteback:                0 kB
WbReclaimable:              0 kB
WbDirtyThresh:              0 kB
WbDirtied:                  0 kB
WbWritten:                  0 kB
WbWriteBandwidth:      102400 kBps
b_dirty:                    0
b_io:                       0
b_more_io:                  0
b_dirty_time:               0
state:                      1

ubuntu24.04 desktop + kernel 6.12.0
default cgroups, not configured manually.

---
Thanks
Jim Zhao

