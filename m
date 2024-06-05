Return-Path: <linux-fsdevel+bounces-21048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52078FD156
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEA01C236C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DE4482C3;
	Wed,  5 Jun 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD7ZrY+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0444776A;
	Wed,  5 Jun 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599795; cv=none; b=OSOVOFRFTpiqLeRNW7m1TW8vfqGsYyDlCu4r1itx9p1u3zkBu9ZX+l8bG5DQ7zbPejfZ5l0+2YCpz46FI2c+te2dlBXz5PMs0Sfs2bjqfuea5XGzSYkfgfmyIz5h/uCdPdP8SJzzGc4/pbLNZt27Tzncazr/MNm/JR72Y+Rxt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599795; c=relaxed/simple;
	bh=iqV2acmMzOLGBC90yH0i7PZOjKc+YcoOzvs2GcSNu0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiIcRWpdZ54O09DnsqqNesTdQU9rDyRC+Q5dcC/oA0yOLjbnAFnZzLmw+zCdYzINI82OSYw4yd6rAJ1cU8dlVqc68nkDtRxJ1AMkyry16g5Ab8fP0yDSwwooapvoJzp1TSHVEVZmVQJ3XDzFj/Q3KgJ2JyZwNZsNuGytx3hnZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD7ZrY+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED8C2BD11;
	Wed,  5 Jun 2024 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717599794;
	bh=iqV2acmMzOLGBC90yH0i7PZOjKc+YcoOzvs2GcSNu0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CD7ZrY+xO4CHKNb+DEk8cqYB/csWTMoUhn0/v8yXjBWT77Yq7kUBYB3B3jgoAJZPm
	 Gwh3p9Nh6Tnn4xQjZzCjO4AFzUuyrjj4xy+NJmpELrIVwF5s0TqLP6kCSe/hyhj2U5
	 I9swmUvsDLbgNMYRkfQ8CMsH/a7G6MScLZ2KXc0dy/nMspx15DoLMsjCslS/FTDXo/
	 gavP5OCIt2rBM/jG7g6eMRioA+zVrDoPqypDg2O9jUC9esfeZFlMYzdZt9Xy26U9eP
	 aFa+md3b3hH1/TZein3rlu0W3K7gG0zPEP8gm7ezQm9UKjpiqEOBhFEBat0PvZTZ/E
	 YafsTzQO2DA/Q==
Date: Wed, 5 Jun 2024 17:03:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: shave a branch in getname_flags
Message-ID: <20240605-sonnabend-busbahnhof-3f93ffcac846@brauner>
References: <20240604155257.109500-1-mjguzik@gmail.com>
 <20240604155257.109500-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604155257.109500-4-mjguzik@gmail.com>

On Tue, Jun 04, 2024 at 05:52:57PM +0200, Mateusz Guzik wrote:
> Check for an error while copying and no path in one branch.

Fine to move that check up but we need to redo it after we recopied.
It's extremely unlikely but the contents could've changed iirc. I can
fix that up though.

