Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7A7114E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbjEYSi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbjEYSiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 14:38:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A451703;
        Thu, 25 May 2023 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3UfPchLUYdWy9KCje7JNWMJZu0GBbqs1XHhZyb9Elpg=; b=dREWFlMgPsOScdh4mHYj5vpNlw
        HeeuA9W7TI40gjiRe+mbNwDH9vWaRtED9kNXnJ7Eusr53g6BtLAuotQypKw9DJH2uep7C9CpsQ1TQ
        bllam3AtdkUmxLMZlhm16mC05+GB2+Gk4N6vp43KXCjFQaya1hE5GmKX/HKra0P2wBWWcjHIEo1V2
        3QPjca4/AhFY57yNLeouXSnrY3JLPy6ofCSM2oqccSgpfEqxBRP9wS2qzKiS/7ETGDwKvXWJBCVSf
        eqlNosa0U3phxMepSLIM4URGOCcoENiqxjZrTOQyp1azZhXnTh3gdW9Ek2FpB4L2sCBWcXpjL3ZiV
        CQJ4yMnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Fnt-00HPwi-2H;
        Thu, 25 May 2023 18:35:13 +0000
Date:   Thu, 25 May 2023 11:35:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>, hch@lst.de,
        brauner@kernel.org, david@redhat.com
Cc:     tglx@linutronix.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate
 detection
Message-ID: <ZG+qYdGsbE7mOn6M@bombadil.infradead.org>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
 <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com>
 <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 11:08:13AM -0700, Luis Chamberlain wrote:
> + fsdevel please review,

> So with two other hunks added (2nd and 4th), this now matches parity with
> my patch, not suggesting this is right, just demonstrating how this
> could be resolved with this. We could also just have a helper which lets
> the module code allow_write_access() at the end of its use of the fd
> (failure to load or module is removed).

This even fixes the pathological case with stress-ng for finit_module:

./stress-ng --module 8192 --module-name xfs

(stress-ng assumes you have all dependencies already loaded and
 the module is not loaded, it uses finit_module() directly)

  Luis
