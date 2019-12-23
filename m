Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46901129BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 00:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLWX20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 18:28:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLWX20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 18:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7mb7xON26qhtQf0NX74LRhG+XskmkDIeOVwCuzcqTuU=; b=SwxABb2svDsI5O720oYxWMvkK
        Jv6NVmb5v9pHuwkquwbxRgz17ov3pqNofkr6IO12fnnAgwG1KpuRdcebUZuA1BhCkylulrOSOBBWj
        q6C+Qx0DooZnBpkR4skSwGQN0qxNlNEL+erqFJ4tQrtkJqmduvrbMdgZLrYC7OlvT5LBnn6Bt6yah
        VwlwAa/roitIuHhRdwunmqf0EUchCmqt9bOPy2u3ea7xLKHO38Lt8QLOJhEj0/PaC/KSx/GH5nPJ9
        C3NirCLS/+B1UY6cAJzPSAEeBCnWL3mmi53Ipc773U4RggQuX53Bn9x/w1AwFlcxN6togTqSqK+4J
        7LX6dwZlg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ijX7g-0007yc-Vu; Mon, 23 Dec 2019 23:28:24 +0000
Date:   Mon, 23 Dec 2019 15:28:24 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/9] lib/string: Add function to trim duplicate WS
Message-ID: <20191223232824.GB31820@bombadil.infradead.org>
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-2-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223225558.19242-2-tasleson@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 04:55:50PM -0600, Tony Asleson wrote:
> +/**
> + * Removes leading and trailing whitespace and removes duplicate
> + * adjacent whitespace in a string, modifies string in place.
> + * @s The %NUL-terminated string to have spaces removed
> + * Returns the new length
> + */

This isn't good kernel-doc.  See Documentation/doc-guide/kernel-doc.rst
Compile with W=1 to get the format checked.

> +size_t strim_dupe(char *s)
> +{
> +	size_t ret = 0;
> +	char *w = s;
> +	char *p;
> +
> +	/*
> +	 * This will remove all leading and duplicate adjacent, but leave
> +	 * 1 space at the end if one or more are present.
> +	 */
> +	for (p = s; *p != '\0'; ++p) {
> +		if (!isspace(*p) || (p != s && !isspace(*(p - 1)))) {
> +			*w = *p;
> +			++w;
> +			ret += 1;
> +		}
> +	}

I'd be tempted to do ...

	size_t ret = 0;
	char *w = s;
	bool last_space = false;

	do {
		bool this_space = isspace(*s);

		if (!this_space || !last_space) {
			*w++ = *s;
			ret++;
		}
		s++;
		last_space = this_space;
	} while (s[-1] != '\0');

> +	/* Take off the last character if it's a space too */
> +	if (ret && isspace(*(w - 1))) {
> +		ret--;
> +		*(w - 1) = '\0';
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(strim_dupe);
> +
>  #ifndef __HAVE_ARCH_STRLEN
>  /**
>   * strlen - Find the length of a string
> -- 
> 2.21.0
> 
