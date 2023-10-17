Return-Path: <linux-fsdevel+bounces-514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BEB7CBFF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 11:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D776B1C20AC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70F4120E;
	Tue, 17 Oct 2023 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k97tu0+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53723405F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 09:54:17 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9337C98
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=95gBHJpbv7/wfHCeOeSKH/7du8d7XC4kqiMmilDw5CI=; b=k97tu0+axo61nf3tdMUIVPxXYb
	q5YlwQh4Y11hdXxZ8VFPjo/kq7NdjXxoSt15vCICvMHmdvtzodVoDkxD61l11nrb/xQ0bAjPjZ4fU
	5GliOOnTJHlMYehNVsVrfYAhooABW6tFE0uVJRgk5reXAZu2qoihSbg/pijg89khBa6L5MvyeFpoS
	ZYnX6Cu9iDzd0mpoh+gbpzCY/WkoIZ35IW3fARC6ssCjNKHah/10qURU76fSq79sRIKUQZwOvBTyE
	L2SM4+6mUWWkUOT3ybXuNWwVtqGrdguvRhH8oRiTaeRHdfuP+YzjjXaR2LbE3ITMtT8UIv39vHr8e
	pYvGPjhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsgmE-0020Lh-06;
	Tue, 17 Oct 2023 09:54:14 +0000
Date: Tue, 17 Oct 2023 10:54:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH] chardev: Simplify usage of try_module_get()
Message-ID: <20231017095413.GP800259@ZenIV>
References: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
 <20231016224311.GI800259@ZenIV>
 <20231017091353.6fhpmrcx66jj2jls@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017091353.6fhpmrcx66jj2jls@pengutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:13:53AM +0200, Uwe Kleine-König wrote:

> I don't understand what you intend to say here. What is "that"? Are you
> talking about
> 
> 	owner && !try_module_get(owner)
> 
> vs
> 
> 	!try_module_get(owner)
> 
> or the following line with kobject_get_unless_zero? Do you doubt the
> validity of my patch, or is it about something try_module_get()
> could/should do more than it currently does?

I'm saying that it would be a good idea to turn try_module_get() into
an inline in all cases, including the CONFIG_MODULE_UNLOAD one.
Turning it into something like !module || __try_module_get(module),
with the latter being out of line.  With that done, your patch would be
entirely unobjectionable...

