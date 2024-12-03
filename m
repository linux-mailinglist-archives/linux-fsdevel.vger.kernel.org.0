Return-Path: <linux-fsdevel+bounces-36319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6270A9E16BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35079161844
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3791DE89C;
	Tue,  3 Dec 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IONi9feh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CE1CD204;
	Tue,  3 Dec 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216925; cv=none; b=MJNQsZ3TuNHk5KRqU6s7FHclo68DD9RilkzTZ5kcn8QoaLkgXqWycGRzPlsGEEdGnHWs5u0fNKu/gJfJDjLUwwfCxa3smD2+/nVLehm7OXfprJW8rOuB9rYI1o3SM6KCDti23G/l06lxwAxvQ1j7FmEr9VfjMUQBApybt++cGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216925; c=relaxed/simple;
	bh=d8kzUdU9z1KNgveBv3S4BD15LSA6cdX2777PaG6/rDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2i7FXUwWCRejGS/pDoy+J3BOhhz56AMv1q3P+j++A1EC2OVEohLU4f3HZp0qx++LaPoZ5R/0w6vkaueF1mxbefd75cQo0Cx2559RNM6+jl002Zl1PL7tKlvVcGHDTJG53lt/w6nV364V205sSfx4i+fnkS2MQ38zuI+2/Itg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IONi9feh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8691C4CECF;
	Tue,  3 Dec 2024 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733216925;
	bh=d8kzUdU9z1KNgveBv3S4BD15LSA6cdX2777PaG6/rDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IONi9fehl366nb0Wh2p50YS8/i8T5dEhHXPviTCLplVddRNThLvESzbJ8HO1ouRrp
	 PzLJoy1m7gSdOX0dkVBa/7tjKUev89UxIryHFCX1ZqXyLZxbGIWvVhvLEz8KdnTB46
	 tKKrnC9Ph9OBVqN34DLkyiiMqSEpCl8tSnMwd7o2MWbogWpip6stNNCq2UPA63jnG5
	 PzGQQx3PMqdYGk5+Of7YWxfbS1YMM2VHzVw6uKN5HZ7LPb8ObB3Sc7Dr0cPMJkgUZV
	 PaX0zU7JOJFRfmR/Hxy5/1ozPMIxPD4zTiJ9ZxqJ4uVSN1EFizDK1S+sC8hd5R8P3L
	 PsLr/aaUDuJZA==
Date: Tue, 3 Dec 2024 10:08:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Erin Shepherd <erin.shepherd@e43.eu>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	stable <stable@kernel.org>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <20241203-ausmerzen-hauteng-d3610644ef6b@brauner>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <0974893ac7d97cc709ffa7df52fb5e0b7f502a4c.camel@kernel.org>
 <2F18FF7D-5AC9-4EE4-A19A-F016CF5B1971@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2F18FF7D-5AC9-4EE4-A19A-F016CF5B1971@oracle.com>

> Though, I wonder if a similar but separate prohibition
> mechanism might be necessary for other in-kernel network
> file system server implementations (eg, ksmbd).

Oh hm, interesting question.
I have no idea how ksmbd or 9p "exports" work. I really hope they don't
allow exporting arbitrary pseudo-fses.

