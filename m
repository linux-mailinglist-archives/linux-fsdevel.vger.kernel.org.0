Return-Path: <linux-fsdevel+bounces-64254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E55BDFE20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C34C188FE96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE513D503;
	Wed, 15 Oct 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVlDN/ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE4B663
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549671; cv=none; b=gbjHmKJf6ZhrCZnVlMW1Gm/YFnMQ+FZWTGtbClOrXcVrcRlkxwtA4+v9qPTs0EzCYnN05EeOYwWE6kMsyfItmKY11vL1SS4FBEI74Pq2hItGvVOqKz7II7wxDyIYc8yDvkteouXIZ5GsHXSLy86cCYFbaJqSyx7nTtpSwXEislg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549671; c=relaxed/simple;
	bh=q9FgAlh0gVt9jSc85AZ/8SVgGCl0PT5b0P+tGf+0/Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejY1wHQ/R5892+G+2sVEeKCCr1VtiMkzg/TFwAnWTX1D8j6eyEaFE0lwYoUA+o528fxxuzKG3NkVh1l5ELJudO0eJMbK38iQB51NmdEGgbw1G+N61B8jV/MweUSZHqqbWchSM/0jezFB2a1KN11eXQnNGW9Jep/gyT7cUiQiVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVlDN/ju; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f27b67744so27982785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760549669; x=1761154469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9FgAlh0gVt9jSc85AZ/8SVgGCl0PT5b0P+tGf+0/Iw=;
        b=WVlDN/juQ3ncxcUwLLuoq4q33LJv0BG+bsafE6EBxNiFgr5BZlP1zMB1JWybfbyXIf
         5OatWRNOfD+BUbZ5R79iUdm66tVGQwDE8aRyjfLTNSyk+RA6A9KtBHZSGkxWhJGVcVhN
         0gQ98qYYEji4RDga+9UDc8o00LEBuxbJb0PREk8IAcd3bKFviysPSeOuCRBOUBn/05vq
         Y2RmIafTQVKR5eU31kZurQ72NCj5UU7ZsO2a5zQW2oML2SlaFC7judPFcxjropHMovkH
         ZpKvDA9wl/W6NNv5BPu4Wj6ZFdc/FKyK59qvHetG+w7HoHtvcnvUGPto7SnzcGIcsqHw
         L8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549669; x=1761154469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9FgAlh0gVt9jSc85AZ/8SVgGCl0PT5b0P+tGf+0/Iw=;
        b=bZvaL6cqXdMViOK54wVWPo8AaelzrcPulpVrON/jL8oG6eglS0bmy7qsBrluX+b6o3
         T59ErH3Empnji4nUYa4Ih1wmI6iG9u2oUoVp6ICKQbh6+Lds92tbNeJ86UMMw1pVn29D
         AHrd6rAD/1faiks+NzniOGzkGmsT86x4Cj/eTOo5ecYWHY1cLFuBjaPgYhgosl5TYTU3
         53KzrIi8onJK2HGSKjLwzeh5mTsHNX4Zki0NG7NFEeacC4TlqlVrs3qJoY0Na7iLVwbA
         msJ//Gp12kxdClLiKhYmjoS7Xvbb+j0cBAUDA4OHD8myxDQJzJB2gEAsNf1FKirzib93
         3ZdA==
X-Forwarded-Encrypted: i=1; AJvYcCXjgtqqKS+WHtTEbXpLKne4aw1ehE3domRGrBcVHPJgFwTxtsBf8GuW4ziKQgjwDQRpsVDFat3z3a7jM3jA@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQY3lnFus15MBF/upLyPftlCA/ZAT6/LC7iiMJcoGdXXCZPkq
	aFXViVbf2X8Jf+j5YIhTKtascESvRvJePDNXzsmm1huhOMi70Q3mib7nyw0lHItpxw5v3/UmGXe
	ja3ruieEtOwGTHkkGlFDzEn6lKnmNVCA=
X-Gm-Gg: ASbGnctDUHJKz0pjKEkUpUnNGfuBAP7ay3DkSUopcw/xdlPuZLkRmmkjVlPba6KVjEk
	7NnrMwHoVmGE+HO9bFLLmkC7CVQjWtooaYmC3MbBJZgaVC8I3qQ6YZ+gQ9+zk2Y2aONmoYc0wes
	NFB5WW8xbKXg1fiaSEzVbdqaDIyjv89fTKNzre1gIs3PeMtpFvLciXQ7qkgnKegorEmXT7UV5Yz
	a2qzIWRnZFPYmV4kJlO4VWGbEQOH41meKsVrqYZDFyG9Auj1/doz24aYRGudmdO7gWDAmEVWTWN
	sQs=
X-Google-Smtp-Source: AGHT+IEOkiOzUISzaHBBcL7KFdH+MVHc+63kqEg4TN4dbrsmWm9vTN9Q10wkVyB8zm7kNROXCSg18liV45OJlMNSJdw=
X-Received: by 2002:a05:622a:205:b0:4e7:2d83:919c with SMTP id
 d75a77b69052e-4e72d839242mr122326541cf.54.1760549668922; Wed, 15 Oct 2025
 10:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com> <aOxrXWkq8iwU5ns_@infradead.org>
In-Reply-To: <aOxrXWkq8iwU5ns_@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 10:34:17 -0700
X-Gm-Features: AS18NWBtfnFDa5-qCiZVvUdAdF_msVXYW7XEJQ2PLEOWB5PQuMFbG0DiawgdCC4
Message-ID: <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, bfoster@redhat.com, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 8:00=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 09, 2025 at 03:56:03PM -0700, Joanne Koong wrote:
> > The end position to start truncating from may be at an offset into a
> > block, which under the current logic would result in overtruncation.
> >
> > Adjust the calculation to account for unaligned end offsets.
>
> Should this get a fixes tag?

I don't think this needs a fixes tag because when it was originally
written (in commit 9dc55f1389f9 ("iomap: add support for sub-pagesize
buffered I/O without buffer heads") in 2018), it was only used by xfs.
think it was when erofs started using iomap that iomap mappings could
represent non-block-aligned data.


Thanks,
Joanne

>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

