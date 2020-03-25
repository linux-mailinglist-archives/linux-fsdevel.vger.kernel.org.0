Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F13191EE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 03:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCYCPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 22:15:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40688 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYCPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:15:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGvXr-0027FJ-Tn; Wed, 25 Mar 2020 02:13:28 +0000
Date:   Wed, 25 Mar 2020 02:13:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
Message-ID: <20200325021327.GJ23230@ZenIV.linux.org.uk>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:49:48PM -0400, Qian Cai wrote:

> It does not catch anything at all with the patch,

You mean, oops happens, but neither WARN_ON() is triggered?
Lovely...  Just to make sure: could you slap the same couple
of lines just before
                if (unlikely(!d_can_lookup(nd->path.dentry))) {
in link_path_walk(), just to check if I have misread the trace
you've got?

Does that (+ other two inserts) end up with
	1) some of these WARN_ON() triggered when oops happens or
	2) oops is happening, but neither WARN_ON() triggers or
	3) oops not happening / becoming harder to hit?
