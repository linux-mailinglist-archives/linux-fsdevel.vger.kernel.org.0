Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790D2E90A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 21:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfJ2UPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 16:15:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2UPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LzVdL0wHnm5sm88oPlshU6HxnHkQI6xUUaMFyCCHz6w=; b=S/ChoJyNsr+FqVRPy4QQVpV4T
        bXF701TlM7rUvdvHvnqFCpvuoC+ZovETwZaBjB0uRLaTbraAOdKDuvsT3ObAE8642xb0iy6cFFl0O
        0/5Y2sfvbW7Qd3gOInOIwOBErFrm9Id+U8Cxj10dsgtGyHx3hnrv/Sb1jQAxIz4SWyWIj7DK6pka7
        /DkusRyXN/MSdgQ4u/pXWLZKskmUmx6EB5QM8FsOwKRTuVYJLoErDDGfPI6PFMzBKBHiZoFRUaFwX
        1PRsqK+xuKdm4C298KOmlWbKDy96wMWKY40Fh/Hv7XK7T+WvnhIYVdfx/lfcEvwvnPAU59prGAP7N
        +N83CyUmw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPXth-0007MY-Ed; Tue, 29 Oct 2019 20:15:21 +0000
Date:   Tue, 29 Oct 2019 13:15:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>,
        "boaz@plexistor.com" <boaz@plexistor.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "Manole, Sagi" <Sagi.Manole@netapp.com>
Subject: Re: [PATCH 11/16] zuf: Write/Read implementation
Message-ID: <20191029201521.GC17669@bombadil.infradead.org>
References: <20190926020725.19601-1-boazh@netapp.com>
 <20190926020725.19601-12-boazh@netapp.com>
 <db90d73233484d251755c5a0cb7ee570b3fc9d19.camel@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db90d73233484d251755c5a0cb7ee570b3fc9d19.camel@netapp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 08:08:16PM +0000, Schumaker, Anna wrote:
> > +       return size ?: ret;
> 
> It looks like you're returning "ret" if the ternary evaluates to false, but it's not clear to
> me what is returned if it evaluates to true. It's possible it's okay, but I just don't know
> enough about how ternaries work in this case.

It's an unloved, unwnted GNU extension.  See
https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html

It's really no better than writing:

	return size ? size : ret;

or even better:

	if (size)
		return size;
	return ret;
