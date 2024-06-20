Return-Path: <linux-fsdevel+bounces-22037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518AF91146D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 23:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7530B1C220EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 21:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBF145B38;
	Thu, 20 Jun 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xszFt9O0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879713D8BA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918593; cv=none; b=ps0NgOZxCOsX4DNukqRmq5q+XuWr14iwQPCYGlZv4jZA37Mk3dQ5GEp+yVmFnuVbbgk62UceGHzjj9emI/5HW3abmsdSUfRquNroR/L0j+eArv2O+fzIHZ9Xvn+A9QkGP68MHgA/Fxbe1ZMXQwAaPnOyt/PcMwJ5qARKz6UyGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918593; c=relaxed/simple;
	bh=FPohiolwroWBc3ESE42C7BsmagP7hLWG84tS43lYLxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r14XmXtx88IymmvZ5a05Xe1lUEfElLZLuTNmoK9VI8u6eWbaB0P/EBD8XaMFQ5idoMvF01S0BGEc7BES2CzNf3fgPto0+JVkjhNdaJnCl991eDoT1fnUdzSEkexYe/HdODGRr6fwpnKaIi9TAgM/ZF108fdSdguWwcTbQTtX0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xszFt9O0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9e5fb48faso81325ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718918591; x=1719523391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q32PR8VJwyaaGnJCPVdwaybh8Bp1RWGH3YQnrF9Y1fw=;
        b=xszFt9O0eJ46VHCrmGhZscHBeVAlL0JMfpKNrOeQ+j2v0HwzvYxBfzasXgiavyXkfE
         Xsgy0uMOdmsilzI6LPTuLS+Uljh1xS1aBHO3lwuLA9oThpmjPasIIOzcBq+1w0KDzk4M
         d14dSLjT55a1+gVxl6T6guhgm4HN1s8BLdYGZ8HsyutHbB4rNz0O80m8GI1E8lPBKbq1
         xM0wn6lNJ8YC3cJAz8t5O9ALfV2VKX0hwvuLUA8CSNrNzEqZZPN1U/UOCFB7C3+wBPGz
         TjG0HGRaWIuethXLm8i7NpvoSbBQAy4lLDYiCvLXheaGYaUlVL3jVAQcBUg0m36Pi4m+
         nnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918591; x=1719523391;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q32PR8VJwyaaGnJCPVdwaybh8Bp1RWGH3YQnrF9Y1fw=;
        b=SVVBncrybyO+NkWv22fQODujxMvWp2pfrtpg5a8IvS4GzXylyc3RHHrOpS8rOLFhzp
         R702l2lZdpI1ghV5hDj62AXwb2QsC7/zk0QapY7MgMzEYcIY6/UTkk6cVMHXcTz/qaX3
         dpU3uNKx1sXUupwLDxSliQaDYdKvSGkZznSRqsakqS1sXDLaWswcMUTKIUngDqnZJQTa
         0ca0x2XqHU6XXSMrpeGNK5xUM/pdYlyLdOl3M2AxjEbWLtUBMlhCv1w5NlI3u7k2fQuW
         LGEQMXhoCoc8eqb9TIW+9UzeB5VDvmzs0bCf4k/2Xj8xq6hTJ5IxAaQdCc7eGhigmjL6
         tLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXqjPUyof7mhPceusvsVrKX//54Es0RzJL8qmhz9oAPoAYkdufvXODJMsx6vljVi87UIDTCAEeWhi2PEjSIrNZqDC6CsVyofYYi/btEg==
X-Gm-Message-State: AOJu0Ywk+5k2KLUWMWjmzSXKrPeFSsBndGcOBNIMWDqaU4NVQv48DOfe
	RCjj7uKLZxTNwGr/watamQZ/l99I/fWToQOqgr74DmfvXXg1rYR16wYPGjE5lsw=
X-Google-Smtp-Source: AGHT+IFpAE8rRXH210v7uuhhLHSJBtr+lAuPBX0TSREwLr72nwKk3bIU+qQDyxKzIteobELD9VqsaA==
X-Received: by 2002:a17:903:1cc:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1f9aad9d286mr68451195ad.4.1718918591063;
        Thu, 20 Jun 2024 14:23:11 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:7562:ac7c:9f3c:87fb:fc6a:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5089sm668135ad.193.2024.06.20.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:23:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, 
 martin.petersen@oracle.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
 dchinner@redhat.com, jack@suse.cz, John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, 
 linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org, 
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com, 
 ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com, 
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev, 
 hare@suse.de
In-Reply-To: <20240620125359.2684798-1-john.g.garry@oracle.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
Subject: Re: [Patch v9 00/10] block atomic writes
Message-Id: <171891858790.154563.14863944476258774433.b4-ty@kernel.dk>
Date: Thu, 20 Jun 2024 15:23:07 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 20 Jun 2024 12:53:49 +0000, John Garry wrote:
> This series introduces a proposal to implementing atomic writes in the
> kernel for torn-write protection.
> 
> This series takes the approach of adding a new "atomic" flag to each of
> pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
> When set, these indicate that we want the write issued "atomically".
> 
> [...]

Applied, thanks!

[01/10] block: Pass blk_queue_get_max_sectors() a request pointer
        commit: 8d1dfd51c84e202df05a999ce82cb27554f7d152
[02/10] block: Generalize chunk_sectors support as boundary support
        commit: f70167a7a6e7e8a6911f3a216dc044cbfe7c1983
[03/10] fs: Initial atomic write support
        commit: c34fc6f26ab86d03a2d47446f42b6cd492dfdc56
[04/10] fs: Add initial atomic write support info to statx
        commit: 0f9ca80fa4f9670ba09721e4e36b8baf086a500c
[05/10] block: Add core atomic write support
        commit: 9da3d1e912f3953196e66991d75208cde3e845e1
[06/10] block: Add atomic write support for statx
        commit: 9abcfbd235f59fb5b6379e5bc0231dad831ebace
[07/10] block: Add fops atomic write support
        commit: caf336f81b3a3ca744e335972e86ec7244512d4a
[08/10] scsi: sd: Atomic write support
        commit: bf4ae8f2e6407a779c0368eb0f3e047a8333be17
[09/10] scsi: scsi_debug: Atomic write support
        commit: 84f3a3c01d70efba736bc42155cf32722067b327
[10/10] nvme: Atomic write support
        commit: 5f9bbea02f06110ec5cf95a3327019b3194b2d80

Best regards,
-- 
Jens Axboe




