Return-Path: <linux-fsdevel+bounces-5277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF4809597
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11651F211C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E817731
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IUGByDH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383410DE;
	Thu,  7 Dec 2023 14:18:03 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E8A5B94297A;
	Thu,  7 Dec 2023 22:18:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 545C3942985;
	Thu,  7 Dec 2023 22:18:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701987482; a=rsa-sha256;
	cv=none;
	b=XIxqLONpak5Z/quUPT8ob6a4cz23yAmBWMqP3j/jxcjPTkdsx7iEXhnCZjc9ckUA3zMwkK
	a3M0sTejb63Hhky/bBI5E8sYyAmWO1E99B+dBDyi2dc6Vln3AdIwHfrVmpu0ay0vDMJkp/
	qvPgAQQ8kLLh7ruM8R3fzHwnmqWIt6yeIVpb4kWaOL0VPAoImOvTOw5f1rzJh8/42VHvq7
	hfdE/mLAV3Bw07P5qH+g3H59kOuB8Mij1jCTpdspjGs9mbubGVe6T/BeoBAWnoMQYxMV+p
	mNDv4aZ+u2P0Omm6DKFIyWYLfMjqhZrpLSEDRva8RUE0kBHSnduJbMejIdhMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701987482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=POl4DWLqR/bRNOMgsVfEX6y6MMnMuc7boUj6x6VE23s=;
	b=+CEzdId799XG/75zFnjfEJ4aR1pcDMd03OvuGJfC+gzmuGzrW42soUSV6QCCNxrbPAT+do
	3Sy1FXT3yDwQ3sCIofv4cOkqThnEUJ7LfeXulwubhBw3lS5EXn4gCeorw/BzfAo+jN/J5q
	VpU/ArsZ3XMLoIzkU4U4DgD3Sm4PIFd0D7Uv2c8MaNRxo4XT4S9aXPxEKCOdixCdFMdtU0
	0kUSzxRxtVCekC9q5RyKbbYPXE0RLFALs7dNRVF/lDnGr1LWDWXjT7Fb4cjs9kpg8soCvE
	ITzokZPU1dXp9DUVXogleanKcxklx5fdLlfp20x+ZlMACSsKMR1PGQJL/NZQnw==
ARC-Authentication-Results: i=1;
	rspamd-696ff67dc8-wtjhs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Bottle: 76b24ca367833107_1701987482714_1654256506
X-MC-Loop-Signature: 1701987482714:2977466096
X-MC-Ingress-Time: 1701987482713
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.156.74 (trex/6.9.2);
	Thu, 07 Dec 2023 22:18:02 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4SmTDS4NqFzCb;
	Thu,  7 Dec 2023 14:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1701987482;
	bh=POl4DWLqR/bRNOMgsVfEX6y6MMnMuc7boUj6x6VE23s=;
	h=Date:From:To:Subject:Content-Type;
	b=IUGByDH/0M+ZoVjZfyKlfAaspk+reGSssPqMb8UPZMvCwxqVZ7Rr6yZAlLm1M3bX5
	 S/wqZzZ7iLdjzkLr0SGXMLBwZLuWRvvKrVx7zeetwJYaFYfhyRWm3SUgCH/w2ynJdE
	 GwkNm+LGgWSFUVVRLegOoxkZFhcL41XwxZULXBrlxJnlGX02Q+pxiT6KMFyfMzcB90
	 rSg0djbLhvTuAUrGESvOH98kuZl225JKhcPUrLb8W7GdUNHPhml8fGGg+VINp+tO3L
	 5Cd2J/Y2i2QHkRP9s9dPdxJcLi7TlfwH24Ee3gVfALWQLuqz0AX3doA7lcmx5CkhtT
	 MDfEUl00T5q8g==
Date: Thu, 7 Dec 2023 14:17:57 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org, 
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com, 
	emirakhur@micron.com, Hasan.Maruf@amd.com, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de, 
	luto@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, mhocko@kernel.org, tj@kernel.org, 
	ying.huang@intel.com, gregory.price@memverge.com, corbet@lwn.net, rakie.kim@sk.com, 
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com, 
	peterz@infradead.org
Subject: Re: [RFC PATCH 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <iwvu5bzpxie35u66ice7y2r2n562xmao5gvzkc7rfhfh5phx2i@idvfsdnq4ynf>
Mail-Followup-To: Gregory Price <gourry.memverge@gmail.com>, 
	linux-mm@kvack.org, jgroves@micron.com, ravis.opensrc@micron.com, 
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com, 
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com, 
	vtavarespetr@micron.com, peterz@infradead.org
References: <20231207002759.51418-1-gregory.price@memverge.com>
 <20231207002759.51418-2-gregory.price@memverge.com>
 <uxqkbmqbvcvx6wc3g2h6vhkutv5flrq6rslwdfs7pa6kknupwh@a245pbtfqfgj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <uxqkbmqbvcvx6wc3g2h6vhkutv5flrq6rslwdfs7pa6kknupwh@a245pbtfqfgj>
User-Agent: NeoMutt/20231006

On Thu, 07 Dec 2023, Davidlohr Bueso wrote:

>fyi Rakie's tag needs to be last, per the From.

sorry no, quite the opposite, never mind this :)

