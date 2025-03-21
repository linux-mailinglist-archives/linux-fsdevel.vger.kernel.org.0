Return-Path: <linux-fsdevel+bounces-44706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F7A6BA3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6750419C4D31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3D2236F6;
	Fri, 21 Mar 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhqevEW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAD1F4C9B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558514; cv=none; b=usX2SWSDpOhw/kjI51h9FNCbcuLuEobZgmbyVjx/vIijuDXBldZjj3YUUcOcq6n/IXHP3XQ4uuW+HhnbjERAKA6/N5HH8OuDoe5zTDWm94eA2wDcf9a4CH6fPwBEvOf56R6rm6yLfLFX1e8ltCWVTd2Cv5H4kxY+al2EeKGwgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558514; c=relaxed/simple;
	bh=0XU01fZSojIu9x7r18GU7C84mPITyHH5zNB2u44X/1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB0A4TGknnYc/0cEkFdQRcvCzY5ZnfcJUiwSwXoBbH3Nhbu2nVmiJ0H8zRSULxk9ji/IxU6Kp+7B2I8sIajjgr6DSQ6LPS16Jq+944alW80Xceg0EqrvxT+oSRTM6hA7Ik/fDacxvVVILDEE+vGrrCYm09IXs/WhITMUmrVLA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhqevEW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C39C4CEE7
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742558514;
	bh=0XU01fZSojIu9x7r18GU7C84mPITyHH5zNB2u44X/1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lhqevEW7Sb5yyxBSuDEe9M8hvoSC1WMtKP+nXRkZVlQ+CZc856A6w40lsfFYKmPXo
	 kO3gZd3ZGZSvY2CHTTYYrdHBIbSG5IKOUia4ufiT1M+g+vW9QqNTH6/m5f4rmwr28d
	 eGkEe9awXL9rj1KrPys58Z8/97p7BCesuiVdTIJAc3mCu4ue2vJ2Pby5Pf1tQypQ9y
	 ukgdQxjTfNsmORFllnEGGsBwJgbduLtP4Sm7tibWWDR+KNl15rScVizHXdy25lZ4gJ
	 CUJ1v+gLtSxhGqd584bpGDbBmDgmMlZstJNjsdvSkW6b9xpRF8dboL4fO/p0CFg0u2
	 gkIV2Do3iTQhA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-601b1132110so914657eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 05:01:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWah4/nvnldNblmE0LgRfjSuGP3TyUIxo7RI98LYxCe90ra8WeC2g3/kyugmtoj+4/Rn9iAANr/XYrbo6/r@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmaD2+cIt5ZCZEPKXHuGiVFSiG6SJ9+WwuS+IQE6KA6mm+l8k
	0cFpb0ct3yxgrL5d85wsTQ6/fsyOEI9KKMPkOAPjB8XBebbgMMQ4CeKN4lB0YZAoHBpysblNg4y
	AVnRuoc+gKGdcFkcZ2mbv8FZ6JaM=
X-Google-Smtp-Source: AGHT+IEqR4PSunBoAzfK5sgW6vBaQx4KrBUVwgkxzqPMfiubz/hfN0AsWTgNIsd4b+qJvNdO6b12dA/3XaP8/aYjCss=
X-Received: by 2002:a05:6871:5296:b0:2c2:489d:887 with SMTP id
 586e51a60fabf-2c780344f18mr1866866fac.17.1742558513656; Fri, 21 Mar 2025
 05:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB6316D4A5885812011AD4C06981D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316D4A5885812011AD4C06981D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Mar 2025 21:01:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_QVdP7Aoyz+62gMfEjhWqr3zW631EEYSSR2j6sD6xXyQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jp17c12OsFzbn6dbdzHwDzpb1beG_L2eoRWO6KVVGhPuANR_lQ1OWIpEnc
Message-ID: <CAKYAXd_QVdP7Aoyz+62gMfEjhWqr3zW631EEYSSR2j6sD6xXyQ@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix missing shutdown check
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:28=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> xfstests generic/730 test failed because after deleting the device
> that still had dirty data, the file could still be read without
> returning an error. The reason is the missing shutdown check in
> ->read_iter.
>
> I also noticed that shutdown checks were missing from ->write_iter,
> ->splice_read, and ->mmap. This commit adds shutdown checks to all
> of them.
>
> Fixes: f761fcdd289d ("exfat: Implement sops->shutdown and ioctl")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!

