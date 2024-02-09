Return-Path: <linux-fsdevel+bounces-10907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7B84F348
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0F1281B3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7569D23;
	Fri,  9 Feb 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToT59oQw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951469D0E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474137; cv=none; b=i7RgF34LhMfMZ2sSsqgHpWqt7+VIxFhNbyxG9o5OJdid5k2QQGfl4xBI3/amQgGwIuAvG1l6r7pPDRiDIUW5S/jV6DZbsSYPHkeKEReQLbzQEfwAv+eWayaXqpSe0UMWWInkNjpxMmyLUKehXyMbUmXL2e+zEVmaQFBIlGRx3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474137; c=relaxed/simple;
	bh=lLjn1aJC+/m3yj+ZxpQBQe4nAKZq0HBbT5u/pdzxwyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jgcjk0DSDufZOEBo0fKzLkvZavuOtou7nS8uqLQ2Zikm9xW+N/oqD1f9zrBXitbZo/Edb+jKhd7D9WfTn3Ov/w7mlfv5AdBwm1FdfclQRf998Mqp8vnJVOtuwXbx52Apa/URTyzEu7HD572UipWp7lUuBKro4YB2sVf/uVdD3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToT59oQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E3EC433C7;
	Fri,  9 Feb 2024 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707474136;
	bh=lLjn1aJC+/m3yj+ZxpQBQe4nAKZq0HBbT5u/pdzxwyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToT59oQwl1Po29K2DN+dLtWFEdTgBCrESpDy+EwSEd9fBm8qd98Nq94qd2WPYShqi
	 AmPk/YUY+GAfGrIQA5qHLnixDpGEThzVVNA5cLlEjhbzwttyNJ3byCWOojptjrwqFl
	 blulSVqsK58nL0eLFMRbUBHJgasR2YYAcDCtbJdBlPSZpk7Bp7dn6FBAU8NDYWb3ms
	 APBnU8J5z2h/qxC4YE1myQr0uZHG93NrLw3QqZcea8xM6Mvrq6JZ8r1LpI1E5A/oas
	 FjlhZhGWhEwq5SW65UPqpUo5RhVhDSN0vFbOsa11dUdOEgG4Zk1pdkXrLRww8o73uj
	 BA+/0tF4/xwJw==
Date: Fri, 9 Feb 2024 11:22:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tony Solomonik <tony.solomonik@gmail.com>, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] Add do_ftruncate that truncates a struct file
Message-ID: <20240209-praxen-aufenthalt-55ec39c8c58b@brauner>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240202121724.17461-1-tony.solomonik@gmail.com>
 <20240202121724.17461-2-tony.solomonik@gmail.com>
 <f44a64c6-ec61-4b64-a983-39c456f39e2d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f44a64c6-ec61-4b64-a983-39c456f39e2d@kernel.dk>

On Thu, Feb 08, 2024 at 08:07:29AM -0700, Jens Axboe wrote:
> On 2/2/24 5:17 AM, Tony Solomonik wrote:
> > do_sys_ftruncate receives a file descriptor, fgets the struct file, and
> > finally actually truncates the file.
> > 
> > do_ftruncate allows for passing in a file directly, with the caller
> > already holding a reference to it.
> 
> Christian, this looking good to you now?

Seems good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

