Return-Path: <linux-fsdevel+bounces-62006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF9BB81B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58CB6247F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478427CB35;
	Wed, 17 Sep 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmON3y9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9327AC4C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139179; cv=none; b=qRSy7MFKmCptUUHtCW/0bTEPct2g9ep9zIvEByx7qHALMeIZo7giXMyPnPjb/gNcZ9W7tgqYaKbr/DCcZoFUYYBM+Spl83QGp8lh/aE/Htpz5ipxbJ+AuNKyAfwLmN6GlHG4MYRyNJy9RzP3s6iqh+bWEU0GiC9wH1rpT7pJlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139179; c=relaxed/simple;
	bh=lT+6fz4hGzB3x5TxZKL3rSaWn/F8+CECdWOTuWodsnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcGF3ef2ddDC0JCZZ7q4+1Cqwx4ijkvD2RVHADlyNwXr7oe0NsBsIW/81Brr15Swmei9tvQtrXZBarVVcr8Fd8kdm0i0ifjCtmFeJqEqY21YOWuh9ItsIvHLxD/JT33ZpXS6IQtUM+dCA0qgDURtS08YugM30aEmOIthfWjdf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmON3y9l; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b79773a389so2212791cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758139176; x=1758743976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT+6fz4hGzB3x5TxZKL3rSaWn/F8+CECdWOTuWodsnQ=;
        b=PmON3y9lLR3IbvqiAGHM4q/5lWUHJKbpECsPIUixVzjXkHGdjeK89v3LpHxNXAbHPp
         oaoMXkinM/h5K/dKp0+JLY65AY70YxGcGURRXPF3FWtn2oTQi6xketvulDqE2oZRoxU9
         wNVq6aa4nRaIycM3l0inE/tyyHIGpecHe7vo9LGinL9JNmjT2iBR1HQNMfzRFyzkQUQh
         l3DQAeSrVDiyQadqCxV+RFsZWKM38/q9VAWedo1FlgytlQbeEOatAgFglsUMhCOCvabf
         gZ6FjR9Vb8RvIIs1tCQwVhYyO1hgGmD1NfZA6NBddCa1lpTFS20/y+iLc8VM5iTvP1+O
         77ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139176; x=1758743976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT+6fz4hGzB3x5TxZKL3rSaWn/F8+CECdWOTuWodsnQ=;
        b=hThKhwB+02kYbSVmAerKuYTsW7g1cOYCb+xmLyGkdK1n6o8yYlD/44wgouQPa9Ur7a
         3FPoTb+pbVk19miD0JCDDpsUwn02dcwvSa6lRZ0tS6BUP/d7CqQR1bMpL9TCG8UIBqoU
         DMnBZFZ6gVbrwYL0qhFaLtgj1Lz0I6FHzF74SpEQ44UXCVATEOvCTj+Ze4ivsIbMVSpZ
         m6ayI/Iy6bg+hG2mCcP2ncK+hT/4U/SDHXjBv636LOVMJZBXw3auSOjNNcrLCrz/g6C0
         IAtK0Z1s/mE0i3rDxG9fzxijpEl1VnmxgOTpJEFRX/ckI+SMoAT7zxmU7X/H0WRLWNVN
         Nv/w==
X-Forwarded-Encrypted: i=1; AJvYcCXhNSy1Xetq64tWxdNo9hNUbbpD40R41BZp1jAOMX9iS2jgSi/VfSt/X4Gxv4qh3HivRKIDIsW8s5CStDgM@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpuGIDp97MkqLYBLsmxMtNJEGDD1t4WmrOSKUYxeKNPXUIHhv
	A3DwL9Vwk0TH0SnyeowuZOZR0Bj1O69uxtiQAqsi7lvUbopCyoWiqCOXUjSMDFMDdMPDTubz3OR
	WNNvfS3Ujnw/k0Wf+0LMsgx8aEuyDIuw=
X-Gm-Gg: ASbGncu+hXz9r7mKb7zVLphh1GgKwiQgFm9ernaNHVSPuVE1iCJbdNIPpE1ta71udAR
	KE88eLJnRn6wpXRRmBlF35UVBo5AtI4u36H6E4Bl/QAggFocTneS3RnknSgNCDUHb0jMTztsl8z
	iqSJ0JxwgcmqYYt4IC0ToCrI3gWy/rZbD6lrk/p6wyjIAT6JEnep5Q/1Hq9By6kUkqgEuimo9VT
	gUQiZlyvBPuYiFOjDaayNvbydmoj/tbTXItOVYsbIebUGbtVTYxh2N8qwY=
X-Google-Smtp-Source: AGHT+IGMvsb9hFrlxwdIt/gNCY+ZXtdov7G+eqQ0YehxgnuYGPrrjhUsF8j6K/mIV15UQttqUMf4NVIbg9l0zFWT/EU=
X-Received: by 2002:ac8:5a03:0:b0:4b3:10f0:15ba with SMTP id
 d75a77b69052e-4ba6a20181amr52761081cf.39.1758139176357; Wed, 17 Sep 2025
 12:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com> <68ca71bd.050a0220.2ff435.04fc.GAE@google.com>
In-Reply-To: <68ca71bd.050a0220.2ff435.04fc.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Sep 2025 12:59:25 -0700
X-Gm-Features: AS18NWC14gUDKzQcBj3qPbZdYHs2cE9cQhtC5cBOuvB6NHeNGl3mJTY7LRXGD5w
Message-ID: <CAJnrk1YKPWkaBXe7D2mftN2DMEBqFow80reUGE=2_U8oVFc1tQ@mail.gmail.com>
Subject: Re: [syzbot ci] Re: fuse: use iomap for buffered reads + readahead
To: syzbot ci <syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com>, 
	syzbot <syzkaller@googlegroups.com>
Cc: brauner@kernel.org, djwong@kernel.org, gfs2@lists.linux.dev, 
	hch@infradead.org, hch@lst.de, hsiangkao@linux.alibaba.com, 
	kernel-team@meta.com, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, miklos@szeredi.hu, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:37=E2=80=AFAM syzbot ci
<syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v3] fuse: use iomap for buffered reads + readahead
> https://lore.kernel.org/all/20250916234425.1274735-1-joannelkoong@gmail.c=
om
> * [PATCH v3 01/15] iomap: move bio read logic into helper function
> * [PATCH v3 02/15] iomap: move read/readahead bio submission logic into h=
elper function
> * [PATCH v3 03/15] iomap: store read/readahead bio generically
> * [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_ite=
r()
> * [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_foli=
o_iter()
> * [PATCH v3 06/15] iomap: rename iomap_readpage_ctx struct to iomap_read_=
folio_ctx
> * [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
> * [PATCH v3 08/15] iomap: add public start/finish folio read helpers
> * [PATCH v3 09/15] iomap: add caller-provided callbacks for read and read=
ahead
> * [PATCH v3 10/15] iomap: add bias for async read requests
> * [PATCH v3 11/15] iomap: move buffered io bio logic into new file
> * [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
> * [PATCH v3 13/15] fuse: use iomap for read_folio
> * [PATCH v3 14/15] fuse: use iomap for readahead
> * [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial writes
>
> and found the following issues:
> * WARNING in iomap_iter_advance
> * WARNING in iomap_readahead
> * kernel BUG in folio_end_read
>
> Full report is available here:
> https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
>
> ***
>
Thanks. Do you get run on every patchset that is sent upstream or is
it random? Trying to figure out if this means v2 is right and i just
messed up v3 or if you just didn't run on v2.

Thanks,
Joanne

