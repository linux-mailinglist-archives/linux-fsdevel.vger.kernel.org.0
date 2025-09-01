Return-Path: <linux-fsdevel+bounces-59772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB0DB3E07C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE89617A567
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD53101A3;
	Mon,  1 Sep 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICoNAY8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305392AD14;
	Mon,  1 Sep 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723319; cv=none; b=tkqzNIkLmbRxVP+iqbJduhuaQO1J2rF3Y4bWymUYwCdwFcDNDcPWL7/cxNFnTck5g/BlmP3lYnWv8Regtx4FjqMVv0yJim4sf8ck/wXGlVRUiK78oNGB5VLqmn7LTWsP2l0AfAtN4ChVrV/C5r6iRnOu9pG6qQIBjkoB3GiU5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723319; c=relaxed/simple;
	bh=OT0RPMUSTqBcRn2UJE9uJjDi/WV04eMSM0ir77EGpuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+dvzhJ/VpqrH3aU50OFAR9lWHsAJuJTnJxQz2mbALGGX/bsOEB3RCOJGhWBps5G5E7upse+3uKUQU1FtnnxVUZU7du2T41HT7YjfmiqCLWFQmBoJtIP1tzE/xASCt1cdal3ICbagULCMQYYTfa2fSADVeiCHeTLF2yrd4Ct5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICoNAY8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CA3C4CEFA;
	Mon,  1 Sep 2025 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756723318;
	bh=OT0RPMUSTqBcRn2UJE9uJjDi/WV04eMSM0ir77EGpuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICoNAY8TYxi8DMWeFl41XIW0ZkA54gsxKR7Wy1HOcjaleLU3Bqjxbs935KyHyCRaW
	 8I5NCNkLjd0m1Tz5vzKqm12qoSuUekS3NEe1Dta2IO17zBi+7TN2TZFDOuI1VXTvBr
	 CrjNGe4lb7hLuTZQvZVDPvtwMu5jGZ1cSK+Ng01vznlvmDpkphzYUCncOHWln0PotO
	 YMmtUBRr8RYsDFIKnf8nXyehmN4HOngax45GY/zlFcbJmZfe3pN2xKenzBgEA7p1BV
	 H9TSi31YnI0v5NPYgf6uwUowvFzijzCF7mCOxxtWr+vpc87eU/gcQxHWxOt9JCu1yK
	 zeL2NRB8D06/A==
Date: Mon, 1 Sep 2025 12:41:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: revamp iput()
Message-ID: <20250901-umrahmen-pocht-7d79f9d2500a@brauner>
References: <20250827-kraut-anekdote-35789fddbb0b@brauner>
 <20250827162410.4110657-1-mjguzik@gmail.com>
 <CAGudoHE5UmqcbZD1apLsc7G=YmUsDQ=-i=ZQHSD=4qAtsYa3yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHE5UmqcbZD1apLsc7G=YmUsDQ=-i=ZQHSD=4qAtsYa3yA@mail.gmail.com>

> Christian, I think it would be the most expedient if you just made

Ok, thanks.

