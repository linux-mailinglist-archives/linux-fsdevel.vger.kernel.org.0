Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B04193256
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 22:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCYVH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 17:07:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55570 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYVH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:07:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHDF7-002oCO-H9; Wed, 25 Mar 2020 21:07:17 +0000
Date:   Wed, 25 Mar 2020 21:07:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
Message-ID: <20200325210717.GO23230@ZenIV.linux.org.uk>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
 <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
 <20200325040359.GK23230@ZenIV.linux.org.uk>
 <20200325055830.GL23230@ZenIV.linux.org.uk>
 <C2554121-109E-450A-965F-B8DFE2B0E528@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2554121-109E-450A-965F-B8DFE2B0E528@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 03:43:06PM -0400, Qian Cai wrote:

> Since that one has a compilation warning, I have tested this patch and seen no crash so far.
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 311e33dbac63..73851acdbf3a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1806,6 +1806,9 @@ static const char *handle_dots(struct nameidata *nd, int type)
>                                          parent, inode, seq);
>                 }
>  
> +               if (unlikely(error))
> +                       return error;
> +

OK, an equivalent of that had been folded into #work.dotdot/#for-next
I'll definitely throw a mentioning of your reporting that thing;
do you want tested-by: added there as well?
