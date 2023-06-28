Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521EF740F00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjF1Kkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 06:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjF1KiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:38:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359819B6;
        Wed, 28 Jun 2023 03:38:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B04C61F8CD;
        Wed, 28 Jun 2023 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687948701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjzHtPro9Ner4jNsUFvbzQkAe6zc+I/EVaSBi1coQGk=;
        b=lDd2o0gI3rUCEnCrSAtsdlSRBwcA6RkoN7NIuSqs3FUIUTdwu/GY/2tF8OqZu176VKoYqq
        m6qW33R3Yu5gv7lX9SkaEsxw2l68AXvxZ3aJE+Yy+I/avacs8I3yMwkC4CDiQtGHNV6j8d
        pci/GT6ET5tT6KMYlL4WhMRgT4zoSEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687948701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjzHtPro9Ner4jNsUFvbzQkAe6zc+I/EVaSBi1coQGk=;
        b=J+kOUIr6cuQb0fhEWDEsuGaDa6vQQiSF8i6pRHXDKrINHw2LdopIByw7+qSC/ZRjMKuX1G
        SxZrQdvwyy31CTBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1F16138E8;
        Wed, 28 Jun 2023 10:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FEF6J50NnGRXIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 10:38:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23586A0707; Wed, 28 Jun 2023 12:38:21 +0200 (CEST)
Date:   Wed, 28 Jun 2023 12:38:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: Re: [PATCH v3 0/3+1] fanotify accounting for fs/splice.c
Message-ID: <20230628103821.dnrbnext26ojviyz@quack3>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZJu8OUwWgz1zDVf5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJu8OUwWgz1zDVf5@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-06-23 21:51:05, Christoph Hellwig wrote:
> Can you please resend this outside this thread?  I really cant't see
> what's new or old here if you have a reply-to in the old thread.
> 
> On Tue, Jun 27, 2023 at 06:55:22PM +0200, Ahelenia Ziemiańska wrote:
> > In 1/3 I've applied if/else if/else tree like you said,
> > and expounded a bit in the message.
> > 
> > This is less pretty now, however, since it turns out that
> > iter_file_splice_write() already marks the out fd as written because it
> > writes to it via vfs_iter_write(), and that sent a double notification.
> 
> It seems like vfs_iter_write is the wrong level to implement
> ->splice_write given that the the ->splice_write caller has already
> checked f_mode, done the equivalent of rw_verify_area and
> should do the fsnotify_modify.  I'd suggest to just open code the
> relevant parts of vfs_iocb_iter_write in iter_file_splice_write.

Yeah, looking into the code I agree (with a small remark that unlike
vfs_iocb_iter_write() this particular variant also needs to work with files
providing only ->write and not ->write_iter). But we can live with
duplicate events for now and this seems like a rather separate cleanup to
do.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
