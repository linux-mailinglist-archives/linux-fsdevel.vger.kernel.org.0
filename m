Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CDC16ACF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 18:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBXRSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 12:18:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48104 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXRSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:18:41 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6HNP-000Pok-RL; Mon, 24 Feb 2020 17:18:39 +0000
Date:   Mon, 24 Feb 2020 17:18:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: Rename __is_local_mountpoint to is_local_mountpoint
Message-ID: <20200224171839.GB23230@ZenIV.linux.org.uk>
References: <20200224170142.5604-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224170142.5604-1-nborisov@suse.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 07:01:42PM +0200, Nikolay Borisov wrote:
> Current is_local_mountpoint is a simple wrapper with added d_mountpoint
> check. However, the same check is the first thing which
> __is_local_mountpoint performs. So remove the wrapper and promote the
> private helper to is_local_mountpoint. No semantics changes.

NAK.  "No semantics changes" does not cut it - inline helper that checks
some unlikely condition and calls an out-of-line version is a fairly
common pattern, with legitimate uses.  It *may* be unwarranted here,
but you need more serious analysis than that.  I'm not saying that
the patch is wrong, but you'll also need to explain why removing the
check from __is_local_mountpoint() (and marking the condition unlikely
in the wrapper) would be worse than what you propose.
