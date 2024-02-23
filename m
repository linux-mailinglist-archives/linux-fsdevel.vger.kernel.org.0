Return-Path: <linux-fsdevel+bounces-12528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3998608A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 03:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF58E28524F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2DBA2B;
	Fri, 23 Feb 2024 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jVvL27NG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A1B64C;
	Fri, 23 Feb 2024 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653751; cv=none; b=nJNoKr8rQiFOKbd2Xh9TL5beWPwrzAZLggBx+scFpxyadEmxH2wyqFVs3PHdVtz+kM4+XjDaZskvFWeIZ4ciXYNkmPTI/vCTkskXawaorLqLlhEumgVfiuzbkt859jTnVK4si9QogSDW2OWoFnR4PnSArV4eJpFXSrSHyLMFOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653751; c=relaxed/simple;
	bh=kskjPTTlnk02nTjU48Vi66RZJJMp2qq4Ciroo9/vrsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdkONlOoi/zDeX2SmCXPR+w5AXtUdOiO4patL3++J3f04kQflXo4W7VR9iwW9/KKmQSM53r/mNIIl+sd4nygh9yApodnBNUnLV4uJ1CbMvWhyCTjsHiZy9nrYyzQZsKGLafQX6yycCgdNwrq0PClvozyhHXbgYQ4/sKYje9oI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jVvL27NG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RAxe3zaRk0aWqw8E+fLHpaRxO362KUw42r1LgGHaRXs=; b=jVvL27NGa/CDDS1qci8KCmp4fm
	TgvSvTH0W/6WhjjMTuCc8k6brKFMasrl/h0d2ANWxvCAIRwaVNmwIA3Bzob2KktoI6/CpRp7sbM/j
	D1koFPdrztFYe3INwQyyMut4ACb7ph0srU0iWuAzTl50zF2FdP52hX3DUjVGikiOuwCQoTs/Lsdmo
	1Yld0pqlkrgJsc/tIfedSA6JOwMwdxYFUxHgj1KzHQqQenKaiVPok/48wsQMb6x/urarDEhQPMK52
	O7IvCifCJ0iF7jypplu9db3RwlweJdxT6Z6o2gegCOOkvNVw4LSBiK3c8/iKSOVqDh/SmyOtr5FcB
	HG98/b0Q==;
Received: from [179.93.188.12] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rdKtM-002Wuk-RJ; Fri, 23 Feb 2024 03:02:25 +0100
Date: Thu, 22 Feb 2024 23:02:16 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
References: <20240222203013.2649457-1-cascardo@igalia.com>
 <87bk88oskz.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk88oskz.fsf@mail.parknet.co.jp>

On Fri, Feb 23, 2024 at 10:52:12AM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> > The tools used for creating images for the Lego Mindstrom EV3 are not
> > adding '.' and '..' entry in the 'Projects' directory.
> >
> > Without this fix, the kernel can not fill the inode structure for
> > 'Projects' directory.
> >
> > See https://github.com/microsoft/pxt-ev3/issues/980
> > And https://github.com/microsoft/uf2-linux/issues/6
> >
> > When counting the number of subdirs, ignore .. subdir and add one when
> > setting the initial link count for directories. This way, when .. is
> > present, it is still accounted for, and when neither . or .. are present, a
> > single link is still done, as it should, since this link would be the one
> > from the parent directory.
> >
> > With this fix applied, we can mount an image with such empty directories,
> > access them, create subdirectories and remove them.
> 
> This looks like the bug of those tools, isn't it?
> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Which they refused to fix, arguing that there are already filesystems out there
in the world like that. Also, there is argument that this works on Windows,
though I haven't been able to test this.

https://github.com/microsoft/pxt-ev3/issues/980
https://github.com/microsoft/uf2-linux/issues/6

Thanks.
Cascardo.

