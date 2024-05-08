Return-Path: <linux-fsdevel+bounces-18983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA208BF3F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 03:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABBE2854CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F78946C;
	Wed,  8 May 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jYonm/yn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469179EA;
	Wed,  8 May 2024 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131081; cv=none; b=LC5xvg67Yn4vpYKsgtnxdWg5zwGftxDXoZvK3WQk/Lt7VPcLsOjyj05ghoobPnVZK+PLSmG5sNmous/Dva3IS109m7JK0hMZbGrV77D/MXYAM4+Sy1y8ggZQ8LTwkMMbE3LJuGkBC4yy24TWfSVUKT/ss70vQl/D4TAXOEFPj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131081; c=relaxed/simple;
	bh=jj2KQP2ub0sVi3xfQLP9yZsNYDR+0zm8HmKQaeY8O48=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OIQkB64FgbLdd6sLPjtNReYJLagGXKrLaaWzHYM6qJNfUy1Slim4t+bOvXOU72l5OdLYVILt/yhv2kU6uSt/IuOzHAJmrYC6lXDyg8jv6VR/39YkeQ/IjL5hRZiNGkRZKstAj3rIXt4/hFEvaB9fqMLONAAAAH3wnlPhulVz8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jYonm/yn; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715131069; bh=bXCqxOHnXGAR0rzdG4ht0Yt67x9bWfQlWK66zskQZqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYonm/ynl8I+nvGyIi68cgjeUrXiNx8rpFbas+Yi7licRAKKCKLCVZdtZ7ZUFKqrz
	 AYArmsgtPNCEojicaLjE3O+ytnYRwmGnnfWU1QvDaOyAEKsmf1olL32GbTvNkVlEtr
	 hTPth5lJgvLVKEoLBSFtJfxgq3bhepPceWaKwEOQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 2E4340E6; Wed, 08 May 2024 09:11:36 +0800
X-QQ-mid: xmsmtpt1715130696tuynpi050
Message-ID: <tencent_CBBB5E331C9E521B014B6C1B9B2576BA8E08@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3Xw/Mobo9iGIOo/qTBimLx0Fery84U2qt+xe6wOTv+10vngPKcjAI
	 IqW1+gezsbiVQYJCRmH7WU9LN0jI4i5k9XEySZ3h1cs3xlUABCpOsjcUL5q3y0FOQy3W7QEjadTi
	 h/V3x6xxUTJaXiWgvBlMLdGD+waeX/5UpdyXjEECwt+Yqz7y5zSOVQlabIeA8hY0IYT+cUbh3iAZ
	 7Xn8LDwvy/YCA+9tGqVS7JRjQMtWILKfGrHCp9+iIMU+4NEDz3/nV2I3r5TXzKw0Y18unRavguK9
	 AUKmTXN5lLdVeAGp4R+ZQEE0sJy2jFoEBY9zTWh/Denj4swhfYb6XGfn6qph/4+ANaSwmY2dWirA
	 5JyoVeeautia6lKtcPiw7yqhBUBiQkUDV21Y4ZPASASe/rm9CX1zmb7YJaU2b+SLFSfWYUdDoomS
	 3tIVxMF6rTy5EQlfqqxBmv4KEXUrUvuOwQXWZ1i2qEQyeqdUCs1D5zHm8UOsd/uHG79EjS7DGeFN
	 0EMN867ULqrbV3BtYC3XEH8fAc60csu83MYr5I0QroOeoQXwceQYuy5I5PCjqFwbYAQdAJSQH2PU
	 j2+t4RxoXLQXo4zn3K3KaCmH31XyGUy9knOVFDLyixQMi8YMOniBRWe8oyOuCu9UXj1NclWwoZkz
	 hp2nkDBgP7KNzhBHxvADRsdwCK0swSz3WhWs6yxd5UqXql47ou9zQwq8efNRT5c2pxcl1gKMdhTr
	 +C30+rLU9BHOtvYART3AYPBZ3vFrIPsDF3VBv4HTtM2ibw4IMved6k4mXyPectNEaf+UjG6FeFYe
	 F84HxkAhVISuRZR91FcicIx/ZOxGvDbMRrlwGmPapqZyiAw83wJp0sbQC6ji3G22QYKuGPmKwkul
	 +OrQOsxwPWGvKrgZeLizNu575iZX+wHLFxiq+ThbXSL/WBiYKrKHNii7pFZXGVpo7CbjsYb7M749
	 EAevEEfno=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	eadavis@qq.com,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Date: Wed,  8 May 2024 09:11:37 +0800
X-OQ-MSGID: <20240508011136.3227286-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7chwa5h2y2eotafxfnapxn754n7y3zpze2sm5dif3zyx7hkxcc@2zu6pskc7fbo>
References: <7chwa5h2y2eotafxfnapxn754n7y3zpze2sm5dif3zyx7hkxcc@2zu6pskc7fbo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 7 May 2024 20:59:14 -0400, Kent Overstreet wrote:
> > > diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
> > > index 35ca3f138de6..194e55b11137 100644
> > > --- a/fs/bcachefs/sb-clean.c
> > > +++ b/fs/bcachefs/sb-clean.c
> > > @@ -278,6 +278,17 @@ static int bch2_sb_clean_validate(struct bch_sb *sb,
> > >  		return -BCH_ERR_invalid_sb_clean;
> > >  	}
> > > 
> > > +	for (struct jset_entry *entry = clean->start;
> > > +	     entry != vstruct_end(&clean->field);
> > > +	     entry = vstruct_next(entry)) {
> > > +		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field)) {
> > > +			prt_str(err, "entry type ");
> > > +			bch2_prt_jset_entry_type(err, le16_to_cpu(entry->type));
> > > +			prt_str(err, " overruns end of section");
> > > +			return -BCH_ERR_invalid_sb_clean;
> > > +		}
> > > +	}
> > > +
> > The original judgment here is sufficient, there is no need to add this section of inspection.
> 
> No, we need to be able to print things that failed to validate so that
> we see what went wrong.
The follow check work fine, why add above check ?
   1         if (vstruct_bytes(&clean->field) < sizeof(*clean)) {
  268                 prt_printf(err, "wrong size (got %zu should be %zu)",
    1                        vstruct_bytes(&clean->field), sizeof(*clean));


