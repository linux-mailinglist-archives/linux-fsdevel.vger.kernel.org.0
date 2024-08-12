Return-Path: <linux-fsdevel+bounces-25662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C994E9E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6CB1F22DD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223E16A954;
	Mon, 12 Aug 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dktXsQTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6968139CFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455147; cv=none; b=B3eP93Cpla0jRvfL5OiRbSpctxBngqcuJ81DoKuoW/bdYtRbu0hwAdagZ6fmZ635A08CIG/3AwEvD+nxWbrKaxKWUuk6ovYI9BlLTQOQrEteHGBm7lPOkvr1Spj0L/Idgz0s3+TEYUJH6myJqxmB5MacqGk/2L8hVJ5ZGdkcTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455147; c=relaxed/simple;
	bh=8qn9KXcvTPUvXanIE9PAo+hgp4tiIf/bXHgjht4rcjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiZyg0ayfd9IUtcdfKOJxUqxlsAslVnfllYB9Wx5M3HcWSaxw48fucpjQA1WqIr3QlgN1ntzg8Hm3BsERBNKI6IuY7Fp7innw2fstEWaza5b+8xKhA8voYDwCvD6HUMQioTlnEEjWbDAVexYBWsOQS8LVetHLSnu6BwFnK1xYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dktXsQTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75AFC4AF0F;
	Mon, 12 Aug 2024 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723455145;
	bh=8qn9KXcvTPUvXanIE9PAo+hgp4tiIf/bXHgjht4rcjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dktXsQTse8bvVUTGg4HRHDFmu9RSlAMbCZutkXi0WohPVlkmIOg4M0oyqOq/wq1sN
	 fdMiI5JNmIAWYLYsxjK4yncHeqI7iPAybmA7fBOU0xWa50BrSohh6ICttiVPYsu+9F
	 bjJa1fltnoK6DucPoHMJ1xEJxUavYF/FRzdSHgLdpwnG8LSztb+hQoNXVm6krLdOO4
	 s5wmN5i1I/cuAE5ea4UlbUob/g5E+xinh0+PxElmvWiLlL7n2MqDpWr7l0liFgzhD/
	 XqDkqTIsssf6QUaihVVH6rlXORxbTn9/CmSZPB+xa+mDfHpHoqraXBjJ4pEXwH9/3+
	 TnTlO6p+5whOg==
Date: Mon, 12 Aug 2024 11:32:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/11] dup_fd(): change calling conventions
Message-ID: <20240812-baumhaus-zugegangen-a1701868aeb0@brauner>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
 <20240812064427.240190-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812064427.240190-11-viro@zeniv.linux.org.uk>

On Mon, Aug 12, 2024 at 07:44:27AM GMT, Al Viro wrote:
> return ERR_PTR() on failure, get rid of errorp
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

