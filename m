Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9B6390EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 22:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKYVAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 16:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYVA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:00:28 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB8391C6;
        Fri, 25 Nov 2022 13:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s4UABV1ux66nah7EYyy5GKkUpPAottxYKhO0fUNPBjk=; b=WINL+1C5RFCsGAMmYeRmkGvFUH
        CjKRYD87yhdW1z3mzkO/wvKYXVtXVi9s2FwZ3TMTHX1R3UhzXfNJyj+oHa95bXcWe7aQJeUsTvcrC
        6SW/qHSRF2xMswuS+blR5PDDrMba6p/sKHR+K9DxLjdUtwACjcVgmk+kXEftKRQW6KuKZyBWC8WMT
        aTnPTOpbuFPuBHCZbDBxaZWZJg8Ah+Kq/KVKlIgGaLbXz9VcJ5CUdT0u85zrRroq5Yor7t84S/0mL
        Z45ew5LwhZtSyY8r5QTPzmcwfoHy5B1iMQcaFTEFyBpALMuPrYuP3iQJ+NfYmcQIk21hYlmGZ1p2U
        DsObimCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyfo1-006kkn-2O;
        Fri, 25 Nov 2022 21:00:17 +0000
Date:   Fri, 25 Nov 2022 21:00:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fs: clear a UBSAN shift-out-of-bounds warning
Message-ID: <Y4Es4TIbVos5CTO9@ZenIV>
References: <20221125091358.1963-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125091358.1963-1-thunder.leizhen@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:13:56PM +0800, Zhen Lei wrote:
> v2 --> v3:
> Updated the commit message of patch 2/2 based on Alexander Viro's suggestion.

Not exactly what I meant...  I've tentatively applied it, with the
following commit message:

--------------------------------
get rid of INT_LIMIT, use type_max() instead

INT_LIMIT() tries to do what type_max() does, except that type_max()
doesn't rely upon undefined behaviour[*], might as well use type_max()
instead.

[*] if T is an N-bit signed integer type, the maximal value in T is
pow(2, N - 1) - 1, all right, but naive expression for that value
ends up with a couple of wraparounds and as usual for wraparounds
in signed types, that's an undefined behaviour.  type_max() takes
care to avoid those...

Caught-by: UBSAN
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
--------------------------------

Does anybody have objections against the commit message above?
