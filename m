Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05851F1A24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgFHNcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 09:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgFHNcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:32:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF981C08C5C2;
        Mon,  8 Jun 2020 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ObZ22oOgYNGbVd4Cp8pB6DVUyibIVTQNw5PapcI68nk=; b=a5taWeGUX4HtnKc/RAOz5WhgUz
        q6JBnbH3JTiA0cXFU9kiCQWCXW/ILe82YRWyyJCFX/BccSHPnnjG1RJ6fzG56MfIi0KikIvn0P9nf
        mSUvR/7yJhmJEjL6YHLbAviatSAnH4qTUW0bZBTaepq+d1h02hdnqQwrHGin2OYMxi/uH2q6I2CFE
        Bmf2dgwgtuy4ue+pK94M55DxD5NmhDOJiqDCKv4agDJrK2TlRU50paxHDYtrUgdGEJVwJptb7wL36
        BMBtG7PyeI/lJRa1zCDx0cj4FHW1VWU83+4CkoMg/YVIb/7CHlo624nM17uJ2flQPUeEY+5R/1ZIc
        7xPFI5/w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiHtR-0001E9-NY; Mon, 08 Jun 2020 13:32:49 +0000
Date:   Mon, 8 Jun 2020 06:32:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 1/8] fs: introduce kernel_pread_file* support
Message-ID: <20200608133249.GW19604@bombadil.infradead.org>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
 <20200606050458.17281-2-scott.branden@broadcom.com>
 <20200606155216.GP19604@bombadil.infradead.org>
 <1591621401.4638.59.camel@linux.ibm.com>
 <20200608131630.GV19604@bombadil.infradead.org>
 <1591622526.4638.71.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1591622526.4638.71.camel@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:22:06AM -0400, Mimi Zohar wrote:
> On Mon, 2020-06-08 at 06:16 -0700, Matthew Wilcox wrote:
> > On Mon, Jun 08, 2020 at 09:03:21AM -0400, Mimi Zohar wrote:
> > > With this new design of not using a private vmalloc, will the file
> > > data be accessible prior to the post security hooks?  From an IMA
> > > perspective, the hooks are used for measuring and/or verifying the
> > > integrity of the file.
> > 
> > File data is already accessible prior to the post security hooks.
> > Look how kernel_read_file works:
> > 
> >         ret = deny_write_access(file);
> >         ret = security_kernel_read_file(file, id);
> >                 *buf = vmalloc(i_size);
> >                 bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> >         ret = security_kernel_post_read_file(file, *buf, i_size, id);
> > 
> > kernel_read() will read the data into the page cache and then copy it
> > into the vmalloc'd buffer.  There's nothing here to prevent read accesses
> > to the file.
> 
> The post security hook needs to access to the file data in order to
> calculate the file hash.  The question is whether prior to returning
> from kernel_read_file() the caller can access the file data.

Whether you copy the data (as today) or map it (as I'm proposing),
the data goes into the page cache.  It's up to the security system to
block access to the page cache until it's been verified.
