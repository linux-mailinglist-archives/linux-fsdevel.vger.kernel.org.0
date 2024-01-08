Return-Path: <linux-fsdevel+bounces-7534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE96826D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7495028351B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039F2420E;
	Mon,  8 Jan 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPspt+yj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A124A16;
	Mon,  8 Jan 2024 12:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0312C43395;
	Mon,  8 Jan 2024 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704715277;
	bh=u/Gf4jBTRg05MH8e65PXoSL/NxckPvljMUUgHTRoC8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPspt+yjJrrWQa2O9dA8h6BA7STGdgSh+JBWJX7qIHjMb2CObK+Vr5NcAvTfIBHBu
	 yCZRlVmfh/VdfCDluTZvPT6Lqr/0AYgbX27RK+RbsM0XMF9ej+U6Tgd3joy8Iprwfc
	 QxVi1do+IqzmtqbxSCwlu5N4w1NYEyK0hSFRQmQVnNfnuv7IY7lwwtye4KpVpOmdpQ
	 LBZCBq5NZpD/QvzNOLbaGIjyFwGd2MWrUn0BvO5PUU/Eq/aHcCv+t7Z78DDFIZAzG2
	 8oc7DhefEEWgBIAtmvLYpltoKjYN7/OOh4gBCkypEGcAgC2AwDtlR98pCsiSvdx18x
	 pQVRSL6OBXwLg==
Date: Mon, 8 Jan 2024 13:01:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240108-kontinental-drastisch-9fc9a3486d16@brauner>
References: <20240103222034.2582628-1-andrii@kernel.org>
 <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>

> Also, should "current_user_ns() != token->userns" perhaps be an error
> condition, rather than a "fall back to init_ns" condition?

Yes, I've pointed this out before:

"Please enforce that in order to use a token the caller must be in the
same user namespace as the token as well. IOW, we don't want to yet make
it possible to use a token created in an ancestor user namespace to load
or attach bpf programs in a descendant user namespace. Let's be as
restrictive as we can: tokens are only valid within the user namespace
they were created in."

[1] Re: [PATCH v11 bpf-next 03/17] bpf: introduce BPF token object
    https://lore.kernel.org/r/20231130-katzen-anhand-7ad530f187da@brauner

> 
> Again, none of this is a big deal. I do think you're dropping the LSM
> error code on the floor, and are duplicating the "ns_capable()" vs
> "capable()" logic as-is, but none of this is a deal breaker, just more
> of my commentary on the patch and about the logic here.
> 
> And yeah, I don't exactly love how you say "ok, if there's a token and
> it doesn't match, I'll not use it" rather than "if the token namespace
> doesn't match, it's an error", but maybe there's some usability issue
> here?

