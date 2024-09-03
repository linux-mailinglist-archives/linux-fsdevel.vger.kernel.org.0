Return-Path: <linux-fsdevel+bounces-28355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A98969C15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D341C23221
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A51A42DB;
	Tue,  3 Sep 2024 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="j8UI95Lk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD31A42B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363466; cv=none; b=j0iVYiO+EwGDkpTedpBADvwRmZnqCvoybT4/CkSI50CIrOhmDq2kOquBBZqzbU9eLYFc4v7M5uwcKiwn5kPQh1B/z6gdKvzXEUqTfKK4mGJIBVLFFFgV6jjXvwY3q7KmZXeiBOLfFD+5o5qbNiRow380bO3+KzgBUdv0KWl2aao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363466; c=relaxed/simple;
	bh=O3ZEJ22xs+dj/gilFg+LDOedyKbsX+Txrwu1SOIvA80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9+/5vg+8LO8qYXfxMnhCjRIdQhBuuPK0dNEakCFO5brP2ZrvtSPWBVjlhrEZCMICExrmCX2d1MmiFPcJsDb0F5CcTUVZKT0OvJk1Y9AZhYK40qgkIMMNzqgMjMoIkMwJcKMHaHuAjPBGpnAON8lP+ZeL/MsR6B5Xd0XgYMpKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=j8UI95Lk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 483BawTE025595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 07:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725363422; bh=BfQrKnI6k0uPhdUNQxC8mkW1lleMusSB/XuTcAchULs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=j8UI95LkRX1+X4hhOkv7zycF8TDHoc0gw8WxWZhbnaXVAUNERctBG/cjABfYjoa6Q
	 WQXKlVX8IkHFGmlrL7/JudzJX0iBJ2e8tEsf4m+LEt9G9DhXGhj+xhra1DsjK5qL7O
	 OHtjVjTnWI5ZLbO8smRXfy3eyon6/zEOczpMftjZ8JMPipN7qB3x1ARPNzkSsaTGCc
	 TmduoxriNoUAs7o6JDV0Ui7PBNoq75wEv0/vvFqUT/5yD0+gySlqzfptfEq7+inaLR
	 34BylYa/KnBNhwo7z37TPyYKmTn5u2quoEvRIgyXVIVKSHpdKbao7TSPYJZJcZl1EV
	 er4kDOhMVGXqg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4FF9115C02C4; Tue, 03 Sep 2024 07:36:58 -0400 (EDT)
Date: Tue, 3 Sep 2024 07:36:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        krisman@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
        Christoph Hellwig <hch@lst.de>,
        Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [PATCH v2 2/8] unicode: Create utf8_check_strict_name
Message-ID: <20240903113658.GA1002375@mit.edu>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
 <20240902225511.757831-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902225511.757831-3-andrealmeid@igalia.com>

I'd suggest using the one-line summary:

unicode: create the helper function utf8_check_strict_name()

so that it's a bit more descriptive.

On Mon, Sep 02, 2024 at 07:55:04PM -0300, André Almeida wrote:
> +/**
> + * utf8_check_strict_name - Check if a given name is suitable for a directory
> + *
> + * This functions checks if the proposed filename is suitable for the parent
> + * directory. That means that only valid UTF-8 filenames will be accepted for
> + * casefold directories from filesystems created with the strict enconding flags.
> + * That also means that any name will be accepted for directories that doesn't
> + * have casefold enabled, or aren't being strict with the enconding.

I also suggest wrapping with a fill column of 72 characters, instead
of 80.

						- Ted
						

