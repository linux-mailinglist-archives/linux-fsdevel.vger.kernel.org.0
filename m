Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5A49CD28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 15:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbiAZO7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 09:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiAZO7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:59:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05562C06161C;
        Wed, 26 Jan 2022 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qxeMxfRUaLMSpLpwFwB74fZjrYpQVLKiCtcO5BRK5RE=; b=dOHesa4GRuw1zvErndAT96xBfl
        vpx9wCuzwJ7l3xAu7gwyH5YQqwHb1/Sp21LW4+v6CLgDu+Kr3JBObDZzoHvfO5mINBoZS6icfH/ZV
        bVmVsFPZ44P62xPQeqhJyuWTt2tBYypZWzTvMbxbwczX718rpR5rW/8li897kJVZBJb87HrvM1e7a
        qTct/U3kWhYf42t7uns+2A2dLNHRphAHH7UWBiZEp+Y3Rthdv0thCSgoXnFNv//9TbiHj3k7P5wpU
        Cx4u8nn5tLXULROEpH7DG2MWkfxQ/I0NPoOR7z2Dz5iLJsfDx/B3aFS3qjYfqKQVlOQrsdYBhLD0t
        ViPk0l1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCjm4-00496s-Uv; Wed, 26 Jan 2022 14:59:53 +0000
Date:   Wed, 26 Jan 2022 14:59:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <YfFh6O2JS6MybamT@casper.infradead.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126114447.25776-1-ariadne@dereferenced.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
> but there was no consensus to support fixing this issue then.
> Hopefully now that CVE-2021-4034 shows practical exploitative use
> of this bug in a shellcode, we can reconsider.
> 
> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408

Having now read 8408 ... if ABI change is a concern (and I really doubt
it is), we could treat calling execve() with a NULL argv as if the
caller had passed an array of length 1 with the first element set to
NULL.  Just like we reopen fds 0,1,2 for suid execs if they were closed.
