Return-Path: <linux-fsdevel+bounces-32375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773BA9A4750
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5E8283A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27C205AC5;
	Fri, 18 Oct 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="JnI7MjLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D773136341;
	Fri, 18 Oct 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280750; cv=none; b=KxmAdqtHpeKFTwWWuoyc4WwgW5xh+FIAAn4ZXArw7M3L9V4MvmZAF4ttfuWn2zzuvv9TBD9tWjiaj1iGsVKBD2kv2SEBjRUO6cXrZhJNt3vKf6nuf2FHMoYeNEAQ+KHdswiR5Br/A9n/LSL4sJhayWcFHuhXvixh6r7F0IYOp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280750; c=relaxed/simple;
	bh=WoNS2WkEZYVOM8wev0tvdB9bsyncm7X3aVjlt5Zr1PM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ExDbo4I5/i0cn19GQ0WgPZ8rkBOyr5Rym+AluBdM04ti5e0+G0iiZnoygWgKYDNnrX/j+BVYHnVNkpdboHzC8CNla80cIaLVRFEgJI+49x8noD3B78Kj8KqzICrzIimzCsPvGdOkNhB+yEYIv8+1np4aMpzexalH16Y41aKmuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=JnI7MjLX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC63460005;
	Fri, 18 Oct 2024 19:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1729280745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoNS2WkEZYVOM8wev0tvdB9bsyncm7X3aVjlt5Zr1PM=;
	b=JnI7MjLXG5ItBG46TJhR80qEMJbYrvqfu3kholk922xB1EudlIHs0DEOyPsQv2/Qc/CBe8
	Bnho2mEgiMj3x3O5QdbYD5UBeFDiplWuAz0rezNNzUZohMtP5fvFBUP7mHrFmsDTPR9M7d
	TvksgY1yI3OpBt4yAvWcuEXm+FcMwuJdKKiT84HOmJJsXq2p8Sm1rfXXldTcnELMmi8uig
	F/gsVa3ngOb56kFL4fDji/kDXUvT1XNdDyCb3DRzY7grnwCzi/CiUAxbxASpNdsp7vDjBP
	2lC71lWe8uNHfuS7gwzg8Om73jG2t0sK0lrQqFNBdawA/xSz3XffXuzU7dxaeA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jonathan
 Corbet <corbet@lwn.net>,  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 7/9] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs
 dirs
In-Reply-To: <20241017-tonyk-tmpfs-v7-7-a9c056f8391f@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 17 Oct 2024 18:14:17 -0300")
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
	<20241017-tonyk-tmpfs-v7-7-a9c056f8391f@igalia.com>
Date: Fri, 18 Oct 2024 15:45:42 -0400
Message-ID: <87jze5yz2x.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Enable setting flag FS_CASEFOLD_FL for tmpfs directories, when tmpfs is
> mounted with casefold support. A special check is need for this flag,
> since it can't be set for non-empty directories.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>


--=20
Gabriel Krisman Bertazi

