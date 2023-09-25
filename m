Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD57AD8A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjIYNKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjIYNKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:10:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA74A2;
        Mon, 25 Sep 2023 06:10:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A534FC433C8;
        Mon, 25 Sep 2023 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695647430;
        bh=KaHFGcb4eCN/L6CN3VRogpYG1qS3g0fdivobLbPwMwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tW/wBB5ow5WtT95Mro/iCqYpY0LE4ptnsMGRSmxw3cXKrn1ZZaECwott7Hi5GPOLM
         uiT7CPMlxOGA5CEiqlonQlsHuOKH3rIlt6RUxjBWhZL4a6XmvF8iQfUKJ0+kgW2fMI
         Z48eTmeI2NDleFTWj6iMATl8c65eryu8D6zUIS1GwvLeKPYGZKzwGMsErzW5uYhgVr
         zMrcDsS/ZDcEv9ovbVdZ4wdPij67BjM7Q5L9CjGrJhPc114QK3dhstkqqbRqMfwOb8
         lyeyHMvWpHtCXsHWNeVgnBij0uISYK5huwRXd+qSPkP7xLtvKqNfD9Wh0fa+VbREv4
         1tHxalXFkBlIg==
Date:   Mon, 25 Sep 2023 15:10:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/splice: don't block splice_direct_to_actor() after
 data was read
Message-ID: <20230925-erstklassig-flausen-48e1bc11be30@brauner>
References: <20230919081259.1094971-1-max.kellermann@ionos.com>
 <20230919-kommilitonen-hufen-d270d1568897@brauner>
 <f37c00c5-467a-4339-9e20-ca5a12905cd3@kernel.dk>
 <CAKPOu+_fwVZFXhTuzcWneNcjHJ99n00j_oq+sF8P-zvsPCOdVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_fwVZFXhTuzcWneNcjHJ99n00j_oq+sF8P-zvsPCOdVQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:16:04PM +0200, Max Kellermann wrote:
> On Wed, Sep 20, 2023 at 7:28 PM Jens Axboe <axboe@kernel.dk> wrote:
> > I think adding the flag for this case makes sense, and also exposing it
> > on the UAPI side.
> 
> OK. I suggest we get this patch merged first, and then I prepare a
> patch for wiring this into uapi, changing SPLICE_F_NOWAIT to 0x10 (the
> lowest free bit), add it to SPLICE_F_ALL and document it.
> 
> (If you prefer to have it all in this initial patch, I can amend and
> resubmit it with the uapi feature.)

Please resend it all in one patch. That's easier for all to review.
