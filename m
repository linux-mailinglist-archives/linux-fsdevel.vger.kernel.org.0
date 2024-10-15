Return-Path: <linux-fsdevel+bounces-32014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BF799F3AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBD81C21489
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98911F76CC;
	Tue, 15 Oct 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLsTZ5g6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819E17335C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012026; cv=none; b=RbmmUapucKaKj5TFa9COt91f9BCiQuKNPIaKbjxy9UO7s9XYdXtZ6aHdCDojJOh302jvoUg16CBNteRasAMfc8wovSxi7KROdeBNOqsoScRaYNmwPrOfJsQF4bSI5aCgpZgYJ4DE53y8JCgpKQG+/SzirEu57DrTuVx3L3w2FOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012026; c=relaxed/simple;
	bh=HqdZLWeQl8zKDGP1kZpbGcyFGh649fzkFo/5qKREjdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzJpOoT2e2yiYE7vTsxqhR8ImNg5ICAH+KceWc8tcumakLkRUMSyPTO6ejylwW32GIWTo5Hpn0VleR6/WyBWo2h3is3Nj498HOLZLFqIpXnoqgItdJ08lUBoPpE3P7laXV96j26/DRke2VEYHkCTLj5THygF/azGUMm1uOe/IqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLsTZ5g6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b133184f41so90369385a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729012023; x=1729616823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crN2X5Z4zCtDQ4lFStD53ycDxLHyj4Rc7LATVvktE9U=;
        b=YLsTZ5g64CG+MiQQQHfbfPRCeJeND30TXUsJN9/aoLIpXKIMz9GbyW9WHGs7A1xMN+
         +XhWNpCgTkhMz3aEcLZl/kq/a5FHW+NchsirIXr14DWJOQS6ya3L2cLxc2aiUSe+q/yk
         eWquk8pRy38CYIeCpys/AAHl21MMEBhIj/T8/PJJPXGnmJ6btg7zNzZBVI7EFz5aw1Mm
         O05gx+0ZurWAMPV89Wb2zBHsciVuqH3sBFprrbWmDwqDvHqUuFpzmqZjvdUaFRTLBe2n
         LJFdFszSpCctmpmbhTrZLq0e/yKEckUFSc+U5lA704IVecZdxETabTbdZ87I59/whkrv
         r4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729012023; x=1729616823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crN2X5Z4zCtDQ4lFStD53ycDxLHyj4Rc7LATVvktE9U=;
        b=jkb9VM+hwrAL+0kA6Q4ccqYhANS029I/wDzUNnoFg13X+vfeSZ5bsv21ecV/5iixGR
         f4kzkoUhfsfpEw1MblwgvES9M3XkxZ6ZEa+RbIUHIMpJ7sWOJN1aSHG5n5fr4vLYIZGy
         SpY3tp4Cds9o7VNXedWPE/qlshL0KF61Kn7xyAMCzRtrkZA0bmr1RSIZehzSUAuY4yg3
         b0/MkWHam9kja5u8xSlrDamW5gXNQLxHyuppEOebyBRmTulfJH8sBtdyue+E9UCIGJrA
         8/i/xsRb297Xz1Dq1WLXNJNliH6aZDAM/Tu//JJpFAJGR94D7hourZHv7m4KtDeXJv/X
         WtLw==
X-Gm-Message-State: AOJu0YyBSSJfcXKrUgtkx5f16/DaZSg5OxJlMRnmeBeuRricAf+eixh5
	+gmlh2IWPuf34qPsP+m6kpsigB74NkKwZWtC7J0cb7Iq4nXSnkg/EitP9nRAb6jsbB3uddZK3HM
	NszRCqt2T++8ay8nNzxsx0f+lGB16KwH3
X-Google-Smtp-Source: AGHT+IFkjWwqIzVz68R/NgtcOkitAJyQgcD8gWHaUaChRBh1qnzdsg55sHYZzFMka1Vb+cc9OgBIxCqmy+Z8Bq7+Lc8=
X-Received: by 2002:a05:620a:1b92:b0:7b1:3f88:48ef with SMTP id
 af79cd13be357-7b13f884c4amr172178985a.46.1729012023113; Tue, 15 Oct 2024
 10:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
In-Reply-To: <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 15 Oct 2024 10:06:52 -0700
Message-ID: <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 3:01=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
> > FUSE folios are not reclaimed and waited on while in writeback, and
> > removes the temporary folio + extra copying and the internal rb tree.
>
> What about sync(2)?   And page migration?
>
> Hopefully there are no other cases, but I think a careful review of
> places where generic code waits for writeback is needed before we can
> say for sure.

Sounds good, that's a great point. I'll audit the other places in the
mm code where we might call folio_wait_writeback() and report back
what I find.


Thanks,
Joanne

>
> Thanks,
> Miklos

