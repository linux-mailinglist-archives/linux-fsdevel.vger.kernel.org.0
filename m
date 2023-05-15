Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535B37040DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbjEOWWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245344AbjEOWWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 18:22:15 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 15:21:51 PDT
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D118161A2;
        Mon, 15 May 2023 15:21:47 -0700 (PDT)
Received: from jerom (unknown [128.107.241.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id F0521459;
        Mon, 15 May 2023 16:43:14 -0500 (CDT)
Date:   Mon, 15 May 2023 16:43:12 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        tycho@tycho.pizza, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
Message-ID: <ZGKncJpVPhOiA7XG@jerom>
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
 <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 09:35:59AM +0200, David Hildenbrand wrote:
> On 04.05.23 23:30, Michael McCracken wrote:
> > Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
> > sysctl to 0444 to disallow all runtime changes. This will prevent
> > accidental changing of this value by a root service.
> > 
> > The config is disabled by default to avoid surprises.
> 
> Can you elaborate why we care about "accidental changing of this value by a
> root service"?

Accidental... malicious...  Note that when people run programs as root with
reduced or no capabilities they can still write this file.

> We cannot really stop root from doing a lot of stupid things (e.g., erase
> the root fs), so why do we particularly care here?

Regardless of the "real value" of it, I know for a fact there are lots
of teams out there adding kernel patches to just change the mode of that
file.  Why?  Possibly to satisfy a scanner, because another team says
it's important.

The problem with lockdown is it's all or nothing.  The problem with LSM
for this purpose is that everyone will have to configure their policy
differently.

So I do think it was worth testing the waters with this patch, to reduce
the number of duplicate patches people run with.

-serge
