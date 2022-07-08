Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309CE56BC95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiGHPEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbiGHPEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:04:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F52F67E;
        Fri,  8 Jul 2022 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3jpvp1J2V3RiYjdNlHd4/ahZAB1KUqyXlwmwoUipWJ0=; b=e+7GDgz79BPotjw0lqXGRpcd/B
        OJkyo7ZfBI5HADrhmC15E51UM2IZDoZ+5zsP6A8p7dfQMyPpXNoN/k6FIKqZg8nTJsDigOEg25ZU/
        hUHIeSNm96S6FVnqqKSG0ALs3dNA0lBWk4l0haqvkZMmTS9l6YDquQQZDw92MsZWd2+xit4RC4n+7
        VKvG3pFYh8rMWwcqt4ebIIVNRhA/a59eOhYVcsQQzF3hWuxvdOlOrI8gZtwrXMhLmMFsEIERyTgHm
        KY4eQuyAyk79Tph0/kfYFPo9pRr8dCFiv4mn6o9AKah48N71tdHo+tvD+4fk6GdfLljZA0ApPMHj0
        vMU6//og==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9pWX-003aRS-WF; Fri, 08 Jul 2022 15:04:06 +0000
Date:   Fri, 8 Jul 2022 16:04:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] pci/doe: Use devm_xa_init()
Message-ID: <YshHZXK/dq3apNDu@casper.infradead.org>
References: <20220705232159.2218958-3-ira.weiny@intel.com>
 <20220707160646.GA306751@bhelgaas>
 <YshC+Jaua01dPQak@iweiny-desk3>
 <YshED+nm7LdcmL75@casper.infradead.org>
 <YshFxnBZGUPN5LoC@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YshFxnBZGUPN5LoC@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 07:57:10AM -0700, Ira Weiny wrote:
> > > I'll update this to be more clear in a V1 if it goes that far.  But to clarify
> > > here; the protocol information is a u16 vendor id and u8 protocol number.  So
> > > we are able to store that in the unsigned long value that would normally be a
> > > pointer to something in the XArray.
> > 
> > Er.  Signed long.
> 
> Sorry I misspoke, xa_mk_value() takes an unsigned long.

It does, *but* ...

static inline void *xa_mk_value(unsigned long v)
{
        WARN_ON((long)v < 0);
        return (void *)((v << 1) | 1);
}

... you can't pass an integer that has the top bit set to it.

> Can't I use xa_mk_value() to store data directly in the entry "pointer"?

Yes, that's the purpose of xa_mk_value().  From what you said, it sounded
like you were just storing the integer directly, which won't work.

> +static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
> +{
> +	return xa_mk_value(((unsigned long)vid << 16) | prot);
> +}
> 
> Both Dan and I thought this was acceptable in XArray?

You haven't tested that on 32-bit, have you?  Shift vid by 8 instead of
16, and it'll be fine.

(Oh, and you don't need to cast vid; the standard C integer promotions
will promote vid to int before shifting, and you won't lose any bits)
