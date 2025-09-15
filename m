Return-Path: <linux-fsdevel+bounces-61339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68713B579CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88587A2B55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E0304BCB;
	Mon, 15 Sep 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm1n46DS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D2302173
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937846; cv=none; b=nIB3p8UjOmzzkUChkJZqjIuVUgXsWViY17REFEgw/iCHvqkrOruFlBS7w93Qn8uAXH5yZgifYQPGtXN3WCCHKnXajNteW2bR9l+8XtZQD1Mo9jHmEiGqIlwMDRXrZql4nm4tyPb8fPmlMZyhhT977b9dbQpo9mafuz0xeYLERPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937846; c=relaxed/simple;
	bh=SwirWQIccR4eL5HqwA3jQiTzCY7biVEk/B7deoGeT8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2EP1D4x6FceE2G7Xz5KgP/YZ0N8T121+LiTViKHDFJdNXehEXkkrLIySAqtKc6ShskoJ+zHCOTHeY4eIB2Lqki9QluYgv5NCnWIB7yeMFinXZADF6f+nc9bxqbconzM4ChwKmQbEycpXjuN/XoJnzMUac8la6ak83/wjJJF9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm1n46DS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D47C4CEF1;
	Mon, 15 Sep 2025 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937846;
	bh=SwirWQIccR4eL5HqwA3jQiTzCY7biVEk/B7deoGeT8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fm1n46DSjtZsRnNcEe2l6/7zNT1BvmWu7MUk9rpsoDWZmMNuVomzUsRlgBcT0h48Q
	 zW0nAeYr37S2WEK7jJNUfJiOVgPlIhGRohDez8LU9Vgm/oYSdNSZSNmmBH11213Bmr
	 9WbbXWv3tdHw0Oe7qDs/+rbv9nPo5OjCzrX4X1NogJdLqpug5TY6EDMboXDmmNCZgT
	 /ppNRn5lAFKe5ZBM4Z5IEJ8ERm7qejSKfAXA0yLQ2O/3hdgUJ0sfHXoN1xWDevwqqV
	 qmglYPOLNeUhf806lXQJYpkOWBboP0bOeriVRA3wCwNR7LzagWnDmyar8o2o5xiZtG
	 268ZyYqRpY3RQ==
Date: Mon, 15 Sep 2025 14:04:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 11/21] ksmbd_vfs_kern_path_unlock(): constify path
 argument
Message-ID: <20250915-inschrift-weisung-e48bf1987749@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-11-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:27AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

