Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A03493E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 17:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355967AbiASQYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 11:24:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54644 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243264AbiASQYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:24:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55E96B81A61;
        Wed, 19 Jan 2022 16:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA98BC004E1;
        Wed, 19 Jan 2022 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642609469;
        bh=JLwjrMhYORjDbtJrdY9T2f6OhkR8YPmjN5TDxFOtFRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeUDLGL01nUHVGOveQ/dYOFoUDrXDzLpsjnmz9L0FjnyRoTIinq+s8AtiNRncOnyf
         +DqNkNi/AwfJg1stlufLgp42A3lw4g6dBmuPmtk0S9FQS87SuIX84AJewY6LJXK24G
         FHBJWEH76Gr0GnO0d5BYCebvDo633iTfDbdCRo4Ep7Lf9AUWneN/e5VzDfcpEJHtcV
         +fITMEn7L03AsvCQGMWuzl7bDGIB+hRR9PSRctqx+Q0oNw5ZZAKO/5TQ5t3tsFOUq1
         VWCUVbir7yeBqQDlxSuW0IQYoKjaBwvRfQ9LqEt+tlh2jirhCwEis3P2h08j9au6GK
         iC4S6Q6tSi2ZQ==
Date:   Wed, 19 Jan 2022 17:24:23 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stephen.s.brennan@oracle.com,
        legion@kernel.org, cyphar@cyphar.com
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <20220119162423.eqbyefywhtzm22tr@wittgenstein>
References: <YegysyqL3LvljK66@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YegysyqL3LvljK66@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Mon, 22 Nov 2021 20:41:06 +0300
> Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> 
> Docker implements MaskedPaths configuration option
> 
> 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> 
> to disable certain /proc files. It overmounts them with /dev/null.
> 
> Implement proper mount option which selectively disables lookup/readdir
> in the top level /proc directory so that MaskedPaths doesn't need
> to be updated as time goes on.

I might've missed this when this was sent the last time so maybe it was
clearly explained in an earlier thread: What's the reason this needs to
live in the kernel?

The MaskedPaths entry is optional so runtimes aren't required to block
anything by default and this mostly makes sense for workloads that run
privileged.

In addition MaskedPaths is a generic option which allows to hide any
existing path, not just proc. Even in the very docker-specific defaults
/sys/firmware is covered.

I do see clear value in the subset= and hidepid= options. They are
generally useful independent of opinionated container workloads. I don't
see the same for lookup=.

An alternative I find more sensible is to add a new value for subset=
that hides anything(?) that only global root should have read/write
access too.
