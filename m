Return-Path: <linux-fsdevel+bounces-13271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444986E19E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35377282570
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C140BE7;
	Fri,  1 Mar 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jze1M2+d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F0138C;
	Fri,  1 Mar 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298727; cv=none; b=aPHJTtynUryIuNwrjBSlS7g+gaEX5gWLX3p2swcrt5VkYwloyaffxrID8pI4cDnQ2L8L01MwDAuPczliDQLkFZT2FLhTJ4n+XXjJNQTmCFm8tZiLsrC7bokCCOqmMBmqSvYbC/GzGPw3+Q9D7agQCfJZosU4obDUBMMzIUZ+XGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298727; c=relaxed/simple;
	bh=FqHEPmazeGZLSdmw3+8lxXDZ2LpYgX5OJCWLme3ZdSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyZnmR9n3IrCSrzp6GymBoN+YkJtfz3flgB20GtX/SYW9dxsPZKje8yr6hmKsZ3LIY7xzvHjEBTLAZqWKaQVV5WAiG+LcDs0kjub8P0Jsee/gcMaIIdDLvIqrFfYV+KgDJoHVujnZnUs2O8b4qWXYuvUmnnwmGPorb52Fek1onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jze1M2+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB442C433C7;
	Fri,  1 Mar 2024 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709298726;
	bh=FqHEPmazeGZLSdmw3+8lxXDZ2LpYgX5OJCWLme3ZdSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jze1M2+d4/5vULXiqnomgWl4IdzhZznl1mil4VvcV5A6F8iXoQwgONXbah0SSmCow
	 NvF5FqBiD04IfUCsk7/HoAlk1EG+xZnAG3p9do2BSc7QcCd4khszCpa6J4kfFzKPc6
	 yHxr7I39UHt8F3r5vL54YWQt+Qu4XY80VBV9UB6QfX3sAJl7ZMd1qsY6oU4bxXg9oo
	 wtm6a0Y+45zg+tGmOtvJNdn/Kna/WeSAYXecje30MxNZQBAA0t/ah09RliC4450EK/
	 F6nMqnBWaWDmZDjMjcvOURVZBsDzCXF5tDqDkZXZZAyYNQ2seWnkov19iKe9SVobKj
	 rL5qSKiQbFOGQ==
Date: Fri, 1 Mar 2024 14:12:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240301-abheben-laborversuch-1a2c74c28643@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229163011.16248-1-lhenriques@suse.de>

> Unfortunately, the two filesystems that use this flag (ext4 and overlayfs)
> aren't prepared to have the parameter value set to NULL.  Patches #2 and #3
> fix this.

Both ext4 and overlayfs define

#define fsparam_string_empty(NAME, OPT) \
        __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)

Please add that to include/linux/fs_parser.h so that it can be used by both.

