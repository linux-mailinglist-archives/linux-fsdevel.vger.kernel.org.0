Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494CA338A08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhCLK0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 05:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhCLK0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:26:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4ABC061574;
        Fri, 12 Mar 2021 02:26:23 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lKezq-00F8hH-G7; Fri, 12 Mar 2021 11:26:18 +0100
Message-ID: <0375326f2f20dc82c056d41faee97489a1a03677.camel@sipsolutions.net>
Subject: Re: [PATCH 2/6] module: add support for CONFIG_MODULE_DESTRUCTORS
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 12 Mar 2021 11:26:17 +0100
In-Reply-To: <20210312104627.8b2523b0593c.Ib0fb7906e3d7bd69ebe5eb877e2e9f33ef915d4b@changeid>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
         <20210312104627.8b2523b0593c.Ib0fb7906e3d7bd69ebe5eb877e2e9f33ef915d4b@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-03-12 at 10:55 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> At least in ARCH=um with CONFIG_GCOV (which writes all the
> coverage data directly out from the userspace binary rather
> than presenting it in debugfs) it's necessary to run all
> the atexit handlers (dtors/fini_array) so that gcov actually
> does write out the data.
> 
> Add a new config option CONFIG_MODULE_DESTRUCTORS that can
> be selected via CONFIG_WANT_MODULE_DESTRUCTORS that the arch
> selects (this indirection exists so the architecture doesn't
> have to worry about whether or not CONFIG_MODULES is on).
> Additionally, the architecture must then (when it exits and
> no more module code can run) call run_all_module_destructors
> to run the code for all modules that are still loaded. When
> modules are unloaded, the handlers are called as well.

Oops, I forgot to add this bit to the patch:

--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -16,6 +16,8 @@ SECTIONS {
 
        .init_array             0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
+       .fini_array             0 : ALIGN(8) { *(SORT(.fini_array.*)) *(.fini_array) }
+
        __jump_table            0 : ALIGN(8) { KEEP(*(__jump_table)) }
 
        __patchable_function_entries : { *(__patchable_function_entries) }


Should that be under the ifdef? .init_array isn't, even though it's only
relevant for CONFIG_CONSTRUCTORS.

johannes

