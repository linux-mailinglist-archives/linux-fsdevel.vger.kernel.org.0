Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3813C46E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgAON7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:59:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgAONz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:55:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irj8p-008oCW-0s; Wed, 15 Jan 2020 13:55:27 +0000
Date:   Wed, 15 Jan 2020 13:55:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC v2] binfmt_misc: pass binfmt_misc flags to the interpreter
Message-ID: <20200115135527.GG8904@ZenIV.linux.org.uk>
References: <20191122150830.15855-1-laurent@vivier.eu>
 <b39e59a6-82f2-2122-5b22-4d8a77eda275@vivier.eu>
 <2a464b33-0b1d-ff35-5aab-77019a072593@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a464b33-0b1d-ff35-5aab-77019a072593@vivier.eu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 01:19:16PM +0100, Laurent Vivier wrote:
> Le 07/01/2020 à 15:50, Laurent Vivier a écrit :
> > Hi,
> > 
> > this change is simple, easy to read and understand but it is really
> > needed by user space application interpreter to know the status of the
> > system configuration.
> > 
> > Could we have a comment saying if there is a problem or if it is good to
> > be merged?
> 
> Anyone?

	FWIW, one thing that looks worrying here is that these bits become
userland ABI after this patch - specific values passed in that thing
can't be changed.  And no a single mention of that in fs/binfmt_misc.c,
leaving a nasty trap.  As far as one can tell, their values are fair game
for reordering, etc. - not even visible outside of fs/binfmt_misc.c;
purely internal constants.  And the effect of such modifications after
your patch will not be "everything breaks, patch gets caught by somebody's
tests" - it will be a quiet breakage for some users.

> >>  #define MISC_FMT_OPEN_BINARY (1 << 30)
> >>  #define MISC_FMT_CREDENTIALS (1 << 29)
> >>  #define MISC_FMT_OPEN_FILE (1 << 28)
> >> +#define MISC_FMT_FLAGS_MASK (MISC_FMT_PRESERVE_ARGV0 | MISC_FMT_OPEN_BINARY | \
> >> +			     MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)

IOW, you are making those parts of userland ABI cast in stone forever.
Whether this bit assignment does make sense or not, such things really
should not be hidden.
