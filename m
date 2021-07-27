Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BA3D742F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhG0LVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhG0LVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:21:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E417C061757;
        Tue, 27 Jul 2021 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c5R0G52grx4aFyC0dPp6RQvOsFtN62rnw8wlCJTtrUU=; b=Zj6t9eYu/863mVZ/elIlLxpwnX
        I8GVXorpzFl1OMWcWouiw6OrvyC04EmyOzriJRA9n++lqto/wgG+YAzSoL9++fxQOeHQosDiXVv9E
        YugytScbeH5DAyU1kPZBlopwuQiLx1Y63E7/8/u73q+fjAZ0q0wDtrAhFPnOrn3AdAQSgNsRNSjdW
        qwDGEV0ztdnuk+e5U8I9QJpp/UlfCcsXWH65yHmLzTPcPfpE1m6YCNOXOYwSpjj54sNB4WcQAMNkm
        HTOOh0XjudeB8dxmXQIwqtgBO/FQ3Hqshbm89IKP2TQ/yEtoKHmPqAT3qggeZoZPIE0l4zBTDt2l1
        rkVpskrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8L7r-00ExB2-G3; Tue, 27 Jul 2021 11:20:09 +0000
Date:   Tue, 27 Jul 2021 12:19:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fs: make d_path-like functions all have unsigned size
Message-ID: <YP/r29mss1BqctYT@casper.infradead.org>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727103625.74961-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:36:25PM +0200, Greg Kroah-Hartman wrote:
> When running static analysis tools to find where signed values could
> potentially wrap the family of d_path() functions turn out to trigger a
> lot of mess.  In evaluating the code, all of these usages seem safe, but
> pointer math is involved so if a negative number is ever somehow passed
> into these functions, memory can be traversed backwards in ways not
> intended.

> diff --git a/fs/d_path.c b/fs/d_path.c
> index 23a53f7b5c71..7876b741a47e 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -182,7 +182,7 @@ static int prepend_path(const struct path *path,
>   */
>  char *__d_path(const struct path *path,
>  	       const struct path *root,
> -	       char *buf, int buflen)
> +	       char *buf, unsigned int buflen)
>  {
>  	DECLARE_BUFFER(b, buf, buflen);

I have questions about the quality of the analysis tool you're using.

struct prepend_buffer {
        char *buf;
        int len;
};
#define DECLARE_BUFFER(__name, __buf, __len) \
        struct prepend_buffer __name = {.buf = __buf + __len, .len = __len}

Why is it not flagging the assignment of an unsigned int buflen to
a signed int len?

> +char *__d_path(const struct path *, const struct path *, char *, unsigned int);
> +char *d_absolute_path(const struct path *, char *, unsigned int);
> +char *d_path(const struct path *, char *, unsigned int);
> +char *dentry_path_raw(const struct dentry *, char *, unsigned int);
> +char *dentry_path(const struct dentry *, char *, unsigned int);

While you're touching these declarations, please name the 'unsigned int'
parameter.  I don't care about the others; they are obvious, but an
unsigned int might be flags, a length, or a small grey walrus.
