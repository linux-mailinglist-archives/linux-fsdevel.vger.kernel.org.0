Return-Path: <linux-fsdevel+bounces-51297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB9AD5325
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCD87ABB83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022C178CC8;
	Wed, 11 Jun 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+IUdEhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DD625
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640041; cv=none; b=CMRitc6Fhtt70bNI9mgWgC5iRdOu6btA2Rs8yPDz6KUQp0wBkodUp2IB+62udQqklwGt8MFA+ttkYnqMfFo//5rilWeUFMIW2A02VIz5ZEm++znD+PSRpdOcOHSjbLi0mDQQOvrZVbq/zk8Z73SD7oKOa/7uTh5sg50gpxptIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640041; c=relaxed/simple;
	bh=oFAJJBk23GYK7fClze7q6BFMAOB/nXgdNck2egjkoYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpjovIqJAtEzdmTiQS7uwrQ/2JscRoNuiCX4653bbS7rCRoQDJY5XdnTesLzwbcOVEjklJogyvtUwEQ2FY5NAfIHdw7rhWXNSrq7vtBsoi+YVTQdDunlFyDDSmXG+Kpe1SjsI9nR5vK8edsUswpnlrB8KQ3dtggnYtsitZlZpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+IUdEhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A8CC4CEF1;
	Wed, 11 Jun 2025 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640041;
	bh=oFAJJBk23GYK7fClze7q6BFMAOB/nXgdNck2egjkoYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+IUdEhRY0zsYBItZzimEyZM4jJKYsyPEchiW67mHbLdaxKlD827NHE9+VXDn+sEp
	 w8lj4f4DUepeLeTyrRNwF1Zn9WkJYySZolNd6V1yxY46SdHR8EXJMC/tioVfmjzDl0
	 L7q/tkWuoJHhCnEEzmOLZT89W5HQjPwmYqvwdbHS5sSU4k72G79foPJhN6l0V3Ncxa
	 VTXwHhOYEfLIqrYsSYP+llHEQPA6KTYOJUbMR+7N8nnVfBLcw48Of9SVesQqYtVJVM
	 6ibdkgvgeettxTR1vdgnz9Dr1BVbe8mRe1jCY0H95U/b+Sitoe6P93LzY31ydrHa6d
	 jnhhr3Qh8xVdg==
Date: Wed, 11 Jun 2025 13:07:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 18/26] attach_recursive_mnt(): pass destination mount in
 all cases
Message-ID: <20250611-mitziehen-erdig-ad8dd2b5ef34@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-18-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:40AM +0100, Al Viro wrote:
> ... and 'beneath' is no longer used there
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

