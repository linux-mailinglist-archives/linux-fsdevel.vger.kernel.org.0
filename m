Return-Path: <linux-fsdevel+bounces-71982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE20CD956D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F5E305F33E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B7334696;
	Tue, 23 Dec 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgWz46Dn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D32FD697
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493660; cv=none; b=ZjeBpKYAETLJECNG4PmXK3j6UxXLYyeCS50jsaxC8g4jycFSyYC8ibokgC59E4WK5SukesYVn1h6wNJR2rlmvyjgAMFmApI+sH5EEN30jNoCJ11UcLFCBG68shJM2YQQvE1blLj6Kojy2rEFCkl3Cq4cjWh+ZJDqKFswTtPkWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493660; c=relaxed/simple;
	bh=V/94jwXt2/VaN6/conir65fhVEvy3Y293/LXtBDIEZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWXV3HNE659JEs9dAhmsIX903XENia/czJqoOmmOG0rDcwC5R7PUN/ZsM/tXh74MUoJBF1FgPNFvMtJXHPm76ZnI0DFTh+RsdJstEm3AZFBF2t70/VJT0TCbLOECdpmkalct/iSlS3UlsC4llmoJuhflNwBjBSnEJdgZe6VsFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgWz46Dn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so7992959a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766493657; x=1767098457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/94jwXt2/VaN6/conir65fhVEvy3Y293/LXtBDIEZI=;
        b=PgWz46Dnu1UqHqBfRnEZaaGGLs45P0B9IWyWW5kHmdaLatDsFzNL+r1fUzP2MHSHeC
         DnoVTpsTyTy5W0WYDx4dLRd4Q+irfFEXstqW4tpsa97l9rIBl8vtdTqVwsoE+ZdFBEoT
         lcRtF6BiPaFgIflWGU9/2HnhpURsoiVg7cG9bRN4pZZ+liJZbDk1KViJv3ezB8MPUYlD
         eB0eTY35wKkbPi0KNUe9yqDD91Uk4Ziu2zrtavDvgCc2iB/a5YKG9dg+wIwTlXCoxIz5
         ZkFZPw5l6R4wYpy1hz0EHElw38mcOBYK/y/ukZJ3E7cKKm+HewoAxZTH6cJCEIXG05DN
         B3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493657; x=1767098457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/94jwXt2/VaN6/conir65fhVEvy3Y293/LXtBDIEZI=;
        b=ZKA2TPfqWF3Boto/1JX/p9J+pTehv7fjVNDRskV0k+qm7IgMDSKyuBHoxwBPfp5jke
         C8+Ok2hOZnU2aK2KtscvCXIJ6HGhzIxwhD0/D4Yva2R5CfrU3yhEk4euqE4T5xfrK38g
         8Wv78cptAVKsIEpn3TdBIzdGgpZ9UZxwCdjTItVyfr7hNUgnRpN5gOBnxIxbtMub5Rkz
         yy/krj70aYMPuJUli089LUxTE1WQJ1QcdV6IXEzdmmwJ/Hev7Tc21FzbiJZJCVPxkvRN
         feUPx0VcBBBjfVH8sYZwGrvJPeSiPUZb+NXlXIEw5EGC+ed8CGZHosRe+pOR7MOQLFbK
         VQUg==
X-Forwarded-Encrypted: i=1; AJvYcCWTM82lkmTMz8phqVTLkSiOa9q43NlwhOPKURxT1vRq8UtYOLx/MpRStXNW8WdrGGWKtlZ92Rh6XGZSOvFi@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8dUKbH8cZy16TXWZyU/8Vo9QelOpDiI58B8I35M2bIYdw9li
	oQTeET6WS0KtmBoWr5f8ZcI/hvr9t7PKdi6SQjNkazN4RN58hA0CgjdAD2CnUbjyhMM2tc4Hdp9
	AAu+CfP7YXd6N7jAK9DypF8vFREjqNaE=
X-Gm-Gg: AY/fxX5B6E6r2SSz9mTczD7X6eIKG56qRGCINLReXvNsQgGSgsEacdJ/7N7HP7to14I
	N79VclYWFJtO5xRTTIailiQ+Fc6Y5mWOgxCZuOl0aAvbSWvrJojxWnRzC7v+kCZYvsZUns3JoWS
	JvjaGYB4uGby2CBI0R05+b74gw6BMvosWJgQnhibt20wv9V9Zlwt0WXIq08dlR9Ow+jW522Qn77
	+Yi+FhWPF5QcjLpp22T0KNTGFCwSgCpuo48r1CWSa7usm2WJo/GAI74q48iPkS7NAWEowvusHOp
	LFsJmAhzggKpfKkR4+Dp6DRytvGgVg==
X-Google-Smtp-Source: AGHT+IEhHo/hN4J9FTc1P4sGEYhA78bE8EllUl442/57HCgAcjltBYKaHTxZkZCcOdqcGslEVHdOWBuZgmToXvnbfII=
X-Received: by 2002:a05:6402:3591:b0:64d:ab6b:17e0 with SMTP id
 4fb4d7f45d1cf-64dab6b199dmr2135230a12.27.1766493656805; Tue, 23 Dec 2025
 04:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-4-lihongbo22@huawei.com> <e143fe52-d704-46d3-9389-21645bb19059@linux.alibaba.com>
In-Reply-To: <e143fe52-d704-46d3-9389-21645bb19059@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Dec 2025 13:40:48 +0100
X-Gm-Features: AQt7F2qBtYIkh7GKPTQm5R_Zd5bGQq3KAbZ7Z9YPLbkt7T3I1moSNvGdJ6tD4Nk
Message-ID: <CAOQ4uxjH3JmNd8yiBwz11+j_t=PArPGeGUHCukiNpw9L1BUp6A@mail.gmail.com>
Subject: Re: [PATCH v10 03/10] fs: Export alloc_empty_backing_file
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 10:31=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2025/12/23 09:56, Hongbo Li wrote:
> > There is no need to open nonexistent real files if backing files
> > couldn't be backed by real files (e.g., EROFS page cache sharing
> > doesn't need typical real files to open again).
> >
> > Therefore, we export the alloc_empty_backing_file() helper, allowing
> > filesystems to dynamically set the backing file without real file
> > open. This is particularly useful for obtaining the correct @path
> > and @inode when calling file_user_path() and file_user_inode().
> >
> > Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> (I hope Amir could ack this particular patch too..)

As long as Chritian is ok with this, I don't mind.

Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

