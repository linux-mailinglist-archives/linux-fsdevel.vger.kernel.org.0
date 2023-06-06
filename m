Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92DF7244AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjFFNlk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 6 Jun 2023 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjFFNlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:41:39 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479F7E78
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 06:41:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EF2F863CC135;
        Tue,  6 Jun 2023 15:41:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yUPaWGUO_djX; Tue,  6 Jun 2023 15:41:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8965763CC138;
        Tue,  6 Jun 2023 15:41:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vJ6ehldXma3o; Tue,  6 Jun 2023 15:41:31 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6BB2563CC135;
        Tue,  6 Jun 2023 15:41:31 +0200 (CEST)
Date:   Tue, 6 Jun 2023 15:41:31 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1054147209.3687907.1686058891249.JavaMail.zimbra@nod.at>
In-Reply-To: <ZH8na21G0W8kmY5r@casper.infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org> <20230605165029.2908304-5-willy@infradead.org> <2059298337.3685966.1686001020185.JavaMail.zimbra@nod.at> <ZH6mixCMHce1S+vK@casper.infradead.org> <406990820.3686390.1686032035024.JavaMail.zimbra@nod.at> <ZH8na21G0W8kmY5r@casper.infradead.org>
Subject: Re: [PATCH 4/4] ubifs: Convert do_writepage() to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Convert do_writepage() to take a folio
Thread-Index: uaaF+94KwZnkY/U9Z1Qd/Y/azzBDWw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Matthew Wilcox" <willy@infradead.org>
> On Tue, Jun 06, 2023 at 08:13:55AM +0200, Richard Weinberger wrote:
>> Matthew,
>> 
>> ----- Ursprüngliche Mail -----
>> > Von: "Matthew Wilcox" <willy@infradead.org>
>> > len is folio_size(), which is not 0.
>> > 
>> >        len = offset_in_folio(folio, i_size);
>> 
>> offset_in_folio(folio, i_size) can give 0.
> 
> Oh!  There is a bug, because it shouldn't get here!
> 
>        /* Is the folio fully inside i_size? */
>        if (folio_pos(folio) + len < i_size) {
> 
> should be:
> 
>        /* Is the folio fully inside i_size? */
>        if (folio_pos(folio) + len <= i_size) {
> 
> right?  Consider a file with i_size 4096.  its single-page folio will
> have a pos of 0 and a length of 4096.  so it should be written back by
> the first call to do_writepage(), not the case where the folio straddles
> i_size.

Indeed.
With that change I agree that do_writepage() cannot get called with zero len.
I'll run more tests, so far all is nice an shiny. :-)

Thanks,
//richard
