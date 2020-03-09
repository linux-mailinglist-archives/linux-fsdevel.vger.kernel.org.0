Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C217EC18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 23:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCIWbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 18:31:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32870 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:31:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBQw5-008SiW-0w; Mon, 09 Mar 2020 22:31:45 +0000
Date:   Mon, 9 Mar 2020 22:31:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] xattr: NULL initialize name in simple_xattr_alloc
Message-ID: <20200309223145.GI23230@ZenIV.linux.org.uk>
References: <20200309183719.3451-1-dxu@dxuuu.xyz>
 <19abedb11fae1b96aa052090e7a0d5bbea416824.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19abedb11fae1b96aa052090e7a0d5bbea416824.camel@perches.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 12:30:07PM -0700, Joe Perches wrote:
> On Mon, 2020-03-09 at 11:37 -0700, Daniel Xu wrote:
> > It's preferable to initialize structs to a deterministic state.
> 
> Thanks Daniel.

Not much point, TBH - there are only two callers, both assigning
that field very shortly.  If you want to do it, do it right -
make that
	simple_xattr_alloc(name, value, len)
with kfree(name) done on failure.  And make the callers allocate
the name first.  Simpler cleanup rules on failure exits that
way...
