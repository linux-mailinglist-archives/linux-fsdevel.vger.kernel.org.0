Return-Path: <linux-fsdevel+bounces-16426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB289D576
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF66282BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551A7F7EE;
	Tue,  9 Apr 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfFKRZBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C07E101
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654669; cv=none; b=Tcn4X50GSQh2JhorApe4XaRFs+HLOyLwDRBIU9t/S5fXy1T13S+9LCQCZjeuejZIucxcyZnfNXSfUugs/IJGaKr8KiLsW/6Loz86xMnYat5bHddGOXp65yGIsqv3oAD52j8Sprmspgmpp4YgPR/kCMrAzkA7CqpwFdGjZbR04vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654669; c=relaxed/simple;
	bh=gNnRinMywpFo0Qf8t+VS+vGVj76fGsL0w/9D6jT6TYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3+LPvFEMEc458t8GKw4rRdLnQKKqufZD2rw+UPkJNWxKKR59372s552q280Z5mIW8aaC4+xnqpP9JB7ahs92AK9p9qICqfnDp/yXBCoWNUfcdUywPNmBKKXZiDUcWT1O+7QzrnSkOpKIsCMUbwuvjbOA0fBP6SCIlBR9hRM8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfFKRZBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654D8C43390;
	Tue,  9 Apr 2024 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654668;
	bh=gNnRinMywpFo0Qf8t+VS+vGVj76fGsL0w/9D6jT6TYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfFKRZBbWQ5SsraIYqQMBU6xYRW2ASeWOH8FF5eQ0RLvOBoPGxmdHlPHgC/2hF/5V
	 WYDY9ilasEKvbtg/32WCNWrCkTpcs/GWZpRStOEd3zIOfbYnvIAi1/KcagDOw1sw6H
	 X9QBgFcAvr7zksjPEoVb8h6WWBt6R+PyNgNyasbHuKZPhOhVPs4o4U3i65V27xw24e
	 pUX6hM9Zd8K57LgNDA6roFZsyzz0UC6U+yufNcRMIH8DyeDHKAXgFK4VscDR427EGE
	 qsFStc6MaspOHUdp80R0CV8R9fFTuk1qvsGsA9ohB7wqnSBKhr5BpbAh1GkrrjMzyj
	 TVnCmu1MvDrng==
Date: Tue, 9 Apr 2024 11:24:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 4/6] kernel_file_open(): get rid of inode argument
Message-ID: <20240409-lehrkraft-vorfreude-6963a6af1877@brauner>
References: <20240406045622.GY538574@ZenIV>
 <20240406050113.GD1632446@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406050113.GD1632446@ZenIV>

On Sat, Apr 06, 2024 at 06:01:13AM +0100, Al Viro wrote:
> always equal to ->dentry->d_inode of the path argument these
> days.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

