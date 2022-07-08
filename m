Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822FF56BC55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiGHOuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiGHOuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:50:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA3F3D;
        Fri,  8 Jul 2022 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QAciJFIg4zoCTHHi5juCYJWiFjMadA5FnHFcPU+cSGU=; b=vkiriIIdCQqnGp2fFPao0drgRk
        +uBI7Ksn1Zl7LZxqeJb8Whhcxgt+Ehf2tn4kSsz7FJxOOohPE6FkPZg/kLKdtvBcnFvkxWCsgHZoY
        tBMSbEHEoY3fjeguT4ervzbV6WJkPwm1d4SzR9Mf/jw+F7IcczTm3fBDTHZE3N1ykqCKLXwlRiesD
        ULTCQB3v4lghZ5+lyP9Zx7qTPe8XqwJoU9shAq5Cb2WzyaXDRAjJ+95LpcuDSIRo9Y5FW5ikeWBG4
        mwVK6Dsy2eO2WWG+YuYfoUds+Zt+Hv97W926YpwniFaWLBI+iB9YDWcck+aEmUrfDI4CLdoliHsy8
        VztsQR8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9pIl-003Zr0-Gv; Fri, 08 Jul 2022 14:49:51 +0000
Date:   Fri, 8 Jul 2022 15:49:51 +0100
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
Message-ID: <YshED+nm7LdcmL75@casper.infradead.org>
References: <20220705232159.2218958-3-ira.weiny@intel.com>
 <20220707160646.GA306751@bhelgaas>
 <YshC+Jaua01dPQak@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YshC+Jaua01dPQak@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 07:45:12AM -0700, Ira Weiny wrote:
> On Thu, Jul 07, 2022 at 11:06:46AM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 05, 2022 at 04:21:58PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The XArray being used to store the protocols does not even store
> > > allocated objects.
> > 
> > I guess the point is that the doe_mb->prots XArray doesn't reference
> > any other objects that would need to be freed when destroying
> > doe_mb->prots?
> 
> Yes.
> 
> > A few more words here would make the commit log more
> > useful to non-XArray experts.
> 
> I'll update this to be more clear in a V1 if it goes that far.  But to clarify
> here; the protocol information is a u16 vendor id and u8 protocol number.  So
> we are able to store that in the unsigned long value that would normally be a
> pointer to something in the XArray.

Er.  Signed long.  I can't find drivers/pci/doe.c in linux-next, so
I have no idea if you're doing something wrong.  But what you said here
sounds wrong.

