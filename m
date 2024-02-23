Return-Path: <linux-fsdevel+bounces-12570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D88612A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FFE1C2148E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83876C83;
	Fri, 23 Feb 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqEF6FKZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20517E788
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694847; cv=none; b=S8SiLAFFt58ShaNhK48J9rcXqcHrEj5u67BHfXTLf/WdAsWDdbW2fxyyb61GmR6lBuiMguB3IIcjDb64oRT1eswBtKIAbCbRtO4zweM6109J0IV2qdBw8G5SAGvf6d9OJoF/gr7tJvKHqKAF98rHHjpon/k/oaGZLy60QgddHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694847; c=relaxed/simple;
	bh=oGqMY1QzHsfZ2rW04EC1oAsZEi4EEsHzezK3272dm/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQXJObUfbVEcXICrNC7uT8xEh4yePkVh0oha7rDaYnfMlA7mWqakeXsPZ04wrWhGTeFrZdVp6kIjUYisgCU3Bf8faiOnrlzTgQoK9tF+buE8nOndjZS7gf2tQNt0GJKLzK9yquqKkrLG8dTevIhoIM6K/myIZpS5r1K2DrzSCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqEF6FKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DCAC433F1;
	Fri, 23 Feb 2024 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694847;
	bh=oGqMY1QzHsfZ2rW04EC1oAsZEi4EEsHzezK3272dm/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqEF6FKZzU26Vb3jjyEVaS/CQlqgDSrEmImSGeHyWN7X4PpoGxdcFj6uC9M42DQ82
	 dbw8EEDqOG86ybHVGLV3NbIXG+rDJ+ps0docyAr7DhXXikaq1pyeYD5eJy3APnEgQ6
	 GicQy2O+gMN2sftWuRASJbqgoNzlmVBDlCNygQdCRQsc5Sw418Mxdi1V3OGMTkNvi9
	 j4a9PpRTHHzwS2aMqlQyxCSjATzlH8ugJaBNfEljZUeKMgJYcLbzsO+MqffNLPlINU
	 +DdZe1vGvsupvkoutQ20J4kCuTZkOpQmyTiBi1RcPWF1KYNf48E/iw2yPkt0nimbO2
	 CuBH7Q1NnCUUg==
Date: Fri, 23 Feb 2024 14:27:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223-ansammeln-raven-df0ae086ff4a@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223125706.23760-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223125706.23760-A-hca@linux.ibm.com>

> So you are basically saying that for now it is ok to break everybody's
> system who tries linux-next and let them bisect, just to figure out they
> have to disable a config option?

Let me fix that suggestive phrasing for you. You seem to struggle a bit:

> I think we should flip the default because this is breaking people who
> are trying linux-next and making them bisect which can be annoying.

Yes, that was the intent. I probably should've made that clear. What I
was trying to do is to flip the default to N and fix the policy. When
that is done we should aim to flip back to y.

