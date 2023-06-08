Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B572833B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjFHPF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHPFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81B52D59;
        Thu,  8 Jun 2023 08:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA9F64E59;
        Thu,  8 Jun 2023 15:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE35C433EF;
        Thu,  8 Jun 2023 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686236722;
        bh=Y/EIWGouVnlbKpC9XYTbmAdqBuIsdYRVusOwsLVQBYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f735D9hCJ8h4t/Ej4s3fHyaVbj1J9OMDZMGWYjX0QHr2axT3FlkjlOpWwF1hHnU54
         s1VFWP11DFwUGv621HfcPwcnnRfm+3kG4FzipGCP6tvtmrrcujAvOKsirmN5sEh94G
         q/YfFBjv/8IBXorg7dmTTz7jqIs0RAKRgWznx8bZ4ngtdHIJan0tcN1ZypA8A/iROD
         X7lVwXyDJX2kUF20EKbsVxSiycqL5w+2K1aXltZnpYOvGxt11XfsU0RRNwEYXB1FUP
         9PBJgg17K4EGc/Bja2ZmOy9cdapnq55pqQNZ8Q9rdpgvypIePFXQCVggl5pLwPEasU
         aTSTVje1en/GA==
Date:   Thu, 8 Jun 2023 08:05:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: add frozen sb state helpers
Message-ID: <20230608150522.GD72224@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-3-mcgrof@kernel.org>
 <ZIFhqk6VElD6qXBU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFhqk6VElD6qXBU@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:05:46PM -0700, Christoph Hellwig wrote:
> On Sun, May 07, 2023 at 06:17:13PM -0700, Luis Chamberlain wrote:
> > Provide helpers so that we can check a superblock frozen state.
> > This will make subsequent changes easier to read. This makes
> > no functional changes.
> 
> I'll look at the further changes, but having frozen/unfrozen helpers
> that sound binary while we have 4 shades of gray seems rather confusing
> to me.

That was my first reaction too.

Then it occurred to me that *some* people might still be clued into that
subtlety if they happened to ask themselves why there are predicates for
_is_frozen and _is_unfrozen.

But in the end I think I decided that an enum isn't subtle like that at
all and clearly forgot to reply with that.

--D
