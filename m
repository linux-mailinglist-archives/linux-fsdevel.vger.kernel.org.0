Return-Path: <linux-fsdevel+bounces-36531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E89E55C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5451883D51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC6321767C;
	Thu,  5 Dec 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUN/jewX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE128684
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402731; cv=none; b=s+tJa0NzhBWttjcTla+JEj+FJJJWUPNjVbeAi2/Thlywm1o07sCptE/x8CKx7KLfDlr76trlDeeOjAdA1GFZtQOkyurrUu77FgIp3zg8rTRUYMqcyjhTHL7vMSS4QBSOm7pJpVuuERpXTP1PRYhJQSnuaqYqnOEvudeObXOvtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402731; c=relaxed/simple;
	bh=4Ik3PBBCaPRiEbtgKMi6ryTeKYQlwRMzdCb5p7Qc8xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9FCKd8ngWgDNwvHeS1U2oxK9HqQ2DptqaqjEqm0ZY52wbcan5+wFM/TrZbn+lfsfzDVGqnVxrACrx90GlPrCIXcAGDORFLFTtuedTz46Pk62k3cRu1D6vK3DKsrd3wz2FsKs0wkRSdgXOoWYrflSW0oRVSjbNIPcSj1yIVck/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUN/jewX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65FCC4CEDF
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733402730;
	bh=4Ik3PBBCaPRiEbtgKMi6ryTeKYQlwRMzdCb5p7Qc8xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iUN/jewXnxrdBAHEIAih4geigxwEcBBx521hGR4GA/gYVjHLXlYWKFlsPd0uHLn5m
	 wXmAgXZuc4TfMc3Ckm/4Jmmy2LZupqvRGL9yUBrBfngcjtqACg0ETpxTKEV/1IBL8U
	 El4P7mkWfSvdym0OS+A25Xk7vbQou26d01sohbod4LRNd/3r+BvIEuMRWdmLkyZOSO
	 zr6z7/pTHD5eddQOCgPkhAoZYAML+zRJMc2No6RUGZK31Y3TKrev9nk5tSWiKs1JME
	 Wh+jrF+Azw7FMkYvRabfH4z9OfZ1r3C+RF2Jupltc9VjFtbZloNn/DEaFbwCCumzG3
	 WY7j6MVpU+RKw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2689e7a941fso285749fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 04:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgGZCc+fR+5tjE9nuEk2LriahIp1q0Yy8zR4mjbKgqbRxpnMKXp7z3wThubqtgrLz8I6Q+2EC8twyvu2fE@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTdVHEX85ZdY/xjlAN7zDWkpnKRrNFfB5Muncri7kEXoh9Fzx
	zDw4nf/hIjGmHPRGrb8tUj0916ogSl+r+I+ydRpIJq7reVZiTJjQE/9PFZ7ho/gmljROBkeu/EW
	l01WSxh/NQ51JtPzfefIyz/L6IMU=
X-Google-Smtp-Source: AGHT+IGVAGmtr7o2hkoGW5JhUv7URE9HBQpRGq0pWrOFji8hXI8JYs2KpAJxiAJORCa7pTHeuOaTbBqxJ0ayqQnWH/c=
X-Received: by 2002:a05:6870:d623:b0:29e:7603:be65 with SMTP id
 586e51a60fabf-29e885cae6cmr5397616fac.1.1733402730211; Thu, 05 Dec 2024
 04:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB63164E8CDD8EF7E1F5638C1F81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB63164E8CDD8EF7E1F5638C1F81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 5 Dec 2024 21:45:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2dybH+-p+7Z_QTT5Cu4SchpR9t95DHt3Y0rS5xRB7bg@mail.gmail.com>
Message-ID: <CAKYAXd-2dybH+-p+7Z_QTT5Cu4SchpR9t95DHt3Y0rS5xRB7bg@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix exfat_find_empty_entry() not returning
 error on failure
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:33=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> On failure, "dentry" is the error code. If the error code indicates
> that there is no space, a new cluster may need to be allocated; for
> other errors, it should be returned directly.
>
> Only on success, "dentry" is the index of the directory entry, and
> it needs to be converted into the directory entry index within the
> cluster where it is located.
>
> Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")
> Reported-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
> Tested-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks for your patch!

