Return-Path: <linux-fsdevel+bounces-20121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B898CE826
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 17:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0889282170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1631304B5;
	Fri, 24 May 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPzh8gYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F31EA80;
	Fri, 24 May 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564826; cv=none; b=Nhbg4/9EkE68Ix81dr+x0h1RapsO4ozmWUxSYbq6VCqhj0owywA4Ut2QL7mfG2siAVX0FVPcLzxN0uDvry31QngnDoz3+b6TEmoEF4r6jyWMh9/UykoPVWkTOb2vvyZ0c5Wi5uWk67r9dp/+cCzKFOcHv3yYdFyurVpwPaFIxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564826; c=relaxed/simple;
	bh=7I+MlrFIcsAFr6aFArGk9/6RkVyXb9ZMH8J1XJK4E5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn9gFszrrYRZ/O+0ulYK020yEWkXBvGosWdBHwZCZO650wDh9TsxQAJed0+Qy0Dskvi1mO+AghBBq+vviUFwnxbtuH+2JtS7liHk982Nhn0bbXTkyH8pXO1qgn10S3PL0+wjedr0LgWylANdwJXjXNaqQ0R6u003NLgF3NiUHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPzh8gYs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so3116185e87.1;
        Fri, 24 May 2024 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716564823; x=1717169623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ptPH/gKMj44mK+DBZPwcDgch/F6jOYOlhSFCQQooJI=;
        b=WPzh8gYsnBy5ouBlo23jem7S8OBcC8h/JTC/WCYwVkEXQhp7opsDCFmjHXXrYmrN0w
         ClTJL0X7838GY6TZLjdwUY2fKlU7sBWJh4r1VmSftEi8Kf/hC2Y2rLfed8wROoZXTRa4
         Ax2amyQBSGjm7BvDpqItT78OBOEEYaATxi+llC1Py4DCRnFFEs0du8XmL29+saqBA/mB
         fDBwizbnUGJwgqF2MXYBV/W159tAAIXWDi3g8hkeLDhST2LSsd+9j8eTJq7d9XHDKR9A
         ZL3JaxiVOGCLUa/9batPitQa1STEE5vPGM16wDFjz9jEvJnPpMiB1tpbzLkJHBZl1dUu
         I9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564823; x=1717169623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ptPH/gKMj44mK+DBZPwcDgch/F6jOYOlhSFCQQooJI=;
        b=dE/oVJi6PAsV1KlbCCChNRoP/PrR8S9tyibPxYda0KuZaUe21VsBZfb74YVj53KdNo
         5WhA52KvW0e2I4R+bHnwZC20DbydG+eVy9sLI8oOLgNUmAOSdnrwRS3itMGR6sjL/Pwe
         4EAtTOdKk2IAh9xvrdBxc0+c1a9lBeJIZLaeb8USC+rDDVKNRBB7pFW4YVkOrKsJXAfR
         m1JQtuQA1GOYQ8pgaxRTq87FAHfvYW03HKGfDtauYV4tis7zdOMgjJ3Wq2iNGuQ3kC9F
         b+z7FPwNowiffkPusRRrWIWGUJObO05BMcYo3pvE+w570orXW2nfG/gWOZEZbfEaGEk2
         YRfw==
X-Forwarded-Encrypted: i=1; AJvYcCVcSqczi/cPlwGV/U2lQ2Ne+m1h5id2xNtZsUjH4Gsi/yEs97hFb0gEot8jGlXFXAKKVhzgdyhY4KppE/msQpWEE++U1Rkaybl7KDyTyYRrM4QN7LpRwCY94qjY0gu3RMaBVBVDHHDhmSaq3ddatVKOEOlLsjbGBPn4uoi1BIrJd8IR5cjuhAQ=
X-Gm-Message-State: AOJu0YzUt09m0eqDTZfOb+G98a6eGjLHcLLLVjDD3/V3FdtfWS7YfTu/
	pnT7leuPUEqMZDCKRLqxKYblQAXmPGm7H7oBiSnvg2twVvRR7IIjqNyxpICH5lOT1AIim3yWlEE
	TQ0YcEwgDci1lAz+B+GVi/AoPaew=
X-Google-Smtp-Source: AGHT+IGO93Mz5Yrq+Ung6+leuBDTr4dzk2/EKk5O5ykcgv0u3qZGH81F4jSxktWUki8wPKCwF3dvIKKj5fHssSz6q3E=
X-Received: by 2002:a05:6512:3e1f:b0:529:a161:4781 with SMTP id
 2adb3069b0e04-529a16149a0mr734837e87.7.1716564823004; Fri, 24 May 2024
 08:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <316306.1716306586@warthog.procyon.org.uk> <20240522-weltmeere-rammt-70f03e24b8b4@brauner>
In-Reply-To: <20240522-weltmeere-rammt-70f03e24b8b4@brauner>
From: Steve French <smfrench@gmail.com>
Date: Fri, 24 May 2024 10:33:31 -0500
Message-ID: <CAH2r5mv0x=PT-nfWbybkC5HiKHKN+-KS+Quk81_MEpnY4dpsVQ@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: Christian Brauner <brauner@kernel.org>
Cc: Steve French <stfrench@microsoft.com>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Enzo Matsumiya <ematsumiya@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can add my Tested-by if you would like

On Wed, May 22, 2024 at 2:14=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, 21 May 2024 16:49:46 +0100, David Howells wrote:
> > Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
> > than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense =
of
> > not waiting rather than synchronicity in the sense of not returning unt=
il
> > the op is complete.
> >
> > Without this, generic/590 fails on cifs in strict caching mode with a
> > complaint that one of the writes fails with EAGAIN.  The test can be
> > distilled down to:
> >
> > [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [1/1] netfs: Fix setting of BDP_ASYNC from iocb flags
>       https://git.kernel.org/vfs/vfs/c/33c9d7477ef1
>


--=20
Thanks,

Steve

