Return-Path: <linux-fsdevel+bounces-21866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DC390C729
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 12:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9911A1C216AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8588B1AC25C;
	Tue, 18 Jun 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jy0FOIiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415014D45B
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699624; cv=none; b=OpgIVOLZf1bcQ74LqVpmm8lv91jootq6DeJiYgqzDrQmTex9U5ohJ5yVh7IeA5bYYL6gQqZv2v8ZMvZkQirru/smbTpcy9k9xfVKCjawjF9YG7Lmf/4scHbgFM7q3MvC5qIxwUr/g5oTCxMvcJtdyf1ie+GA9s9AmHdyR5B8Ntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699624; c=relaxed/simple;
	bh=XsGtGCy//tSaGlQno30iMsiQj1PorXqc1l0Or3UMDpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzMao0E4WmLzorjBzRXKZmHvhN3f4yuW8jXMciiOqLF6DioBhCi6YlTalX9VOS1gPEE3KQoio8jbP++aDrh4s8cYd8X/KMh+55Vci/fE12qkl4dFIFbCe21sMOZHKXshA3nqzZJOWavUDdEtikEI0kCnxwQ4Kn0Xxj6o4dwrRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jy0FOIiZ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfb05bcc50dso4994570276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2024 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718699621; x=1719304421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsGtGCy//tSaGlQno30iMsiQj1PorXqc1l0Or3UMDpM=;
        b=Jy0FOIiZB/IleSPzr0fmcCJJULyJJtY9n4QsISsTJM73iRZK5h0ehdksxIIVEn4Qj+
         3UDIiMh6qGZINLkrYA4UT2c+f2TeFkASu5Fkq+fLdkuGBMASNKHrIehHbJOcD9ZlR5of
         W2aiBQz58V7Ah8QsZy1MrNULBscoNq0U/wyBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699621; x=1719304421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsGtGCy//tSaGlQno30iMsiQj1PorXqc1l0Or3UMDpM=;
        b=g7HYpgg/1fGrq+QvgY7pBffALjPBuEqB8H+1Exbrf69bXIOuwsV003031a9BqTlSRP
         y/68EfKm6JjgvaBNIBWX7RISdqk+3k/xPgeHhhZ+xcU5G3aZ18SQ0tAQC9SEOxH5DXb3
         c8TRql7OHK+E1I5PKjsY5gqkQ8poWizYORTqf59xMdOJm/HyaVeBc0yOaVAEULWAF1lZ
         keLm5FviXXJzFwVBfOiCFiobEb/FfhtVLAdY5qp1HoeiCnEWvYrzet+g2icn96POizbU
         5BnoXaWsPWmtI6EIU0/SVtPP9oo9H2AvrlkkgCN5oCFJmKko7O2E0P+SYheEVQQltuw8
         a47g==
X-Gm-Message-State: AOJu0YyLHG7zKaLbVt/T0HhLgT5U5nvSJefTDpPf3PnRYG4cu+/7pnaD
	/R5AbmH9jkTqXjFlbgs1lv03T03E+/O3zTm+GhuuQTOgZTwh5u5pIG40qFLp5AxF1XE0Jvjpnsm
	wiaehsgkJOGFDixoPB06q3B6VbkAAhbdmYxQQdlFP6+l2h9xGP++i
X-Google-Smtp-Source: AGHT+IHCSy2hMj7Ve/VIrl6Jj487fKsOwha4PlY5pM2CqNyl4N6quc1a1YVHNtBMxcxxtFjwYjP9IX6AFOx+Im3Ltw0=
X-Received: by 2002:a25:ad06:0:b0:dfe:520b:88d5 with SMTP id
 3f1490d57ef6-dff154d9bd9mr10829549276.53.1718699620789; Tue, 18 Jun 2024
 01:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD90VcZybb0ZOVrhE-MqDPwEya8878uzA1RBwd68U7x4CufkTQ@mail.gmail.com>
In-Reply-To: <CAD90VcZybb0ZOVrhE-MqDPwEya8878uzA1RBwd68U7x4CufkTQ@mail.gmail.com>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 18 Jun 2024 17:33:28 +0900
Message-ID: <CAD90Vcbt-GE6gP3tNZAUEd8-eP4NVUfET51oGA-CVvcH4=EAAA@mail.gmail.com>
Subject: Re: virtio-blk/ext4 error handling for host-side ENOSPC
To: linux-fsdevel@vger.kernel.org
Cc: Junichi Uekawa <uekawa@chromium.org>, Takaya Saeki <takayas@chromium.org>, tytso@mit.edu, 
	Daniel Verkamp <dverkamp@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The corresponding proposal to virtio-spec is here:
https://lore.kernel.org/virtio-comment/20240618081858.2795400-1-keiichiw@ch=
romium.org/T/#t

Best,
Keiichi

On Mon, Jun 17, 2024 at 12:34=E2=80=AFPM Keiichi Watanabe <keiichiw@chromiu=
m.org> wrote:
>
> Hi,
>
> I'm using ext4 over virtio-blk for VMs, and I'd like to discuss the
> situation where the host storage gets full.
> Let's say you create a disk image file formatted with ext4 on the host
> side as a sparse file and share it with the guest using virtio-blk.
> When the host storage is full and the sparse file cannot be expanded
> any further, the guest will know the error when it flushes disk
> caches.
> In the current implementation, the VMM's virtio-blk device returns
> VIRTIO_BLK_S_IOERR, and the virtio-blk driver converts it to
> BLK_STS_IOERR. Then, the ext4 module calls mapping_set_error for that
> area.
>
> However, the host's ENOSPC may be recoverable. For example, if a host
> service periodically deletes cache files, it'd be nice if the guest
> kernel can wait a while and then retry flushing.
> So, I wonder if we can't have a special handling for host-side's
> ENOSPC in virtio-blk and ext4.
>
> My idea is like this:
> First, (1) define a new error code, VIRTIO_BLK_S_ENOSPC, in
> virtio-blk. Then, (2) if the guest file system receives this error
> code, periodically retry flushing. We may want to make the retry limit
> via a mount option or something.
>
> What do you think of this idea? Also, has anything similar been attempted=
 yet?
> Thanks in advance.
>
> Best,
> Keiichi

