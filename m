Return-Path: <linux-fsdevel+bounces-44734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F5A6C2DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 19:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8056617AACA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63322F395;
	Fri, 21 Mar 2025 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9tWOflK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D38B664;
	Fri, 21 Mar 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583423; cv=none; b=lcjjwNRs37g1zoGLFrmXHqPppq/hmFV5RmBQYo5mSjJPdqd/7zaxojeqD54OFwngHDdSg3w29ztIQHoKjfLBDmC5gQZhHYBm/hCdbbrj182HMgCkmNns5yRn/VppiBvIzHoFrs8khOGkren0RCZMXqupID/fI0hcF64lEqTiN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583423; c=relaxed/simple;
	bh=eZcWcOhHIawWrb9Ml4EQ6aZ1/wyurT/sT6Io8xnVFbk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=t5fqzhajIxkOnVJSu0REAFQCULuzAD8Q8RNYpgY/ugwMLGqXYcVtjygYGkMnfXR/8hqqhh4kwNlr2mUtkIguvr5agj8QacA5cOg0+Aj5aZmoB49beDax/LWWMpg1wQtNLs6LjrXM9zm3k/v/HbMY60QDJ6YAgl+SisZxkGmRLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9tWOflK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so47864255ad.3;
        Fri, 21 Mar 2025 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742583421; x=1743188221; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E6L6wutV3ZHB5tvyGWzOD0ba/O/FC8bdjgSutzT7uag=;
        b=l9tWOflK5wltWV5kxBGiFy+goTiujuRAPUULMft4uJ4e2avM6DQ0WyMy72AqCw+a+r
         4l4Ml7DiFT9JbFBj6kotznAdQCmQpvK/Lhh5eFpetdWdl0Skby0r2GyxNNui3n36Lydi
         S3ajwUnaePB+Pc1OZ9EGW7+Rcc0PoDSqbcKhm3MJLhL2XFN6sA/GC0hsCVtzAQB1Vx68
         NGQrlQ8SjWQcJrf8N9ta2EwMe+C1yK12LR2vtW6q7NVS5vvtUHU0EjxLxmqxdRQqa2IF
         Qk9Q+zsHq0fEHNqVv2VMNG6MMmu4h2BWFPxKDVpuxpVO4sg1yUqk5v+2dCznoq+GAPPl
         cLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583421; x=1743188221;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6L6wutV3ZHB5tvyGWzOD0ba/O/FC8bdjgSutzT7uag=;
        b=aGdsEa1S5wb9wWzcJf29EcuUdCPrb3apO93s60TQy9ShdDux7UHjhN9fie2McHFCb2
         Hgj1bKPyiDqSUPucz1CNXt3enPfrifGB4+ioyDPnPC1XXFdjX3Ga58XPqWre4y0g14QN
         5xtv0fcI8a7H3B3bV7DK34Q6wKTXJ0LRNFK4sa5fPJWfGTGKfkX9X+GtXm5P/symlWx2
         tkpTIP9yVq+ZZanhjWax+QTQrkIOyeyyKXPBDiVohXjX53Y8T0bCXcG/EXx4BmlcRfFw
         nqAHU/kl8R3n3AbGYeJz76Gl8rLpHbZFTPSCtVKCi9mEKjYwJ9tcF3eOIvFapqp7F+g9
         peog==
X-Forwarded-Encrypted: i=1; AJvYcCUHrhcNyXbvEAviKZ9/GX3LjISfuO5JHoNuda4T+cJgvwzcbI7X6GiawAM8M700uuhEFXQGucq+PBTSpw==@vger.kernel.org, AJvYcCWFrgzd5MUCMNuaOlDGSyXbntL+Zg4ndzIR+p0yPgKx3plQBQ+ePhe09xXCL77WYJElW1bjWDbtRU7wC6DcnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq36gpMWY45NRjdCDtnCzeQ64vj7iUVNYh1rlSiuYwSsk0IFTl
	iFOx/19PpgKGRErTEA90r5vLg8cycazrPwLtUhEvoe9ZBwQdliLj
X-Gm-Gg: ASbGncv4Sf+Qc+pHaYfCC/a8vtKChFVNlyoq/3KrQ517aNujWYeAKsafTO0e/4cyVNM
	DBCJd4KKI5E2mtxDXfI+0u5Nlzo9Rs1zlZHduT80cBwct6FINP0g+Ev/kCk2hWCj79WcuoYiMB8
	fU6h7wc21MhtGvi2xvKTxknIh5/uLVKQV6Ut+Lc3Gq697BVjIjdH/cIaVNDz6gbJquE9zsplCNP
	5X0bRF+/tiyuF4H9RGdL1uyL4wQJaFVtItF0NP3IZi+3LKyFZPU8B3nCDEjPDBOZMusEidp72gV
	/yfm8kndYz+fNlxSuEiY2Hq5/JqPuKvL0rxgrg==
X-Google-Smtp-Source: AGHT+IFTR/0mpypKv50+XZ6X8K3cee/U5NEm6S8aE5fxiwEbadWq9uUGE1SDbkJwu58WEomccQhM1w==
X-Received: by 2002:a17:902:ef12:b0:223:88af:2c30 with SMTP id d9443c01a7336-22780d8cfeemr63100365ad.16.1742583420932;
        Fri, 21 Mar 2025 11:57:00 -0700 (PDT)
Received: from dw-tp ([171.76.82.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4d606sm20918565ad.103.2025.03.21.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:57:00 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org, david@fromorbit.com, leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de, willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
In-Reply-To: <20250321050023.GB1831@lst.de>
Date: Sat, 22 Mar 2025 00:09:09 +0530
Message-ID: <87ecyqrzxu.fsf@gmail.com>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org> <87o6xvsfp7.fsf@gmail.com> <20250320213034.GG2803730@frogsfrogsfrogs> <87jz8jrv0q.fsf@gmail.com> <20250321030526.GW89034@frogsfrogsfrogs> <20250321045604.GA1161423@mit.edu> <20250321050023.GB1831@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Fri, Mar 21, 2025 at 12:56:04AM -0400, Theodore Ts'o wrote:
>> As I recall, in the eary days Linux's safety for DIO and Bufered I/O
>> was best efforts, and other Unix system the recommendation to "don't
>> mix the streams" was far stronger.  Even if it works reliably for
>> Linux, it's still something I recommend that people avoid if at all
>> possible.
>
> It still is a best effort, just a much better effort now.  It's still
> pretty easy to break the coherent.


Thanks Ted & Christoph for the info. Do you think we should document
this recommendation, maybe somewhere in the kernel Documentation where
we can also lists the possible cases where the coherency could break?
(I am not too well aware of those cases though).

One case which I recently came across was where the application was not
setting --setbsz properly on a block device where system's pagesize is
64k. This if I understand correctly will install 1 buffer_head for a 64k
page for any buffered-io operation. Then, if someone mixes the 4k
buffered-io write, right next to 4k direct-io write, then well it
definitely ends up problematic. Because the 4k buffered-io write will
end up making a read-modify-write over a 64k page (1 buffer_head). This
means we now have the entire 64k dirty page, while there is also a
direct-io write operation in that region. This means both writes got
overlapped, hence causing coherency issues.

Such cases, I believe, are easy to miss. And now, with large folios
being used in block devices, I am not sure if there is much value in
applications mixing buffered I/O and direct I/O. Since direct I/O write
will just end up invalidating the entire large folio, that means it
could negate any benefits of using buffered I/O alongside it, on the
same block device.


-ritesh

