Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC06E273D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDNPql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjDNPql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:46:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6410B44E;
        Fri, 14 Apr 2023 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SdeHLcTSYz3bBZMhAQ6oPKTfCX/tSinZf6P6S2VKpeo=; b=Ajmlv2sMHJot/zHME5xc3ImVtu
        EEbrEFKpapweJn9RKKzPXOpoRCKhgOWqR9KpNE8m6bWO/t8LZYQI5IQiSgrIDw5i+iGa0udoGv8FB
        0kIEieEcrmj0dn5+P1DUQrW8TklldItMIpKYVL+1c10FKxLr+pCldFtyxfo/oeByq+eP51CxDAtX7
        L0vZ81HjRSs318WEspctN22uQcuKj7D8EwKoqsip/92zBLWKuy9icjM7nLFEjh1hh9TcmyO1klA8O
        xuq0bdpmKL9sfmmt2tin8sSQKl77M5HQuh5npUAUo3cpuzCPfPOoZmlcCHaE29mwfGAcE1VitXMnD
        fH09UGXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnLd9-0091E4-2H;
        Fri, 14 Apr 2023 15:46:31 +0000
Date:   Fri, 14 Apr 2023 16:46:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-morello@op-lists.linaro.org
Subject: Re: [PATCH v2 1/5] fcntl: Cast commands with int args explicitly
Message-ID: <20230414154631.GK3390869@ZenIV>
References: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
 <20230414152459.816046-2-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414152459.816046-2-Luca.Vizzarro@arm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:24:55PM +0100, Luca Vizzarro wrote:
>  	void __user *argp = (void __user *)arg;
> +	int argi = (int)arg;

Strictly speaking, conversion from unsigned long to int is
an undefined behaviour, unless the value fits into the
range representable by int ;-)

>  	case F_SETFD:
>  		err = 0;
> -		set_close_on_exec(fd, arg & FD_CLOEXEC);
> +		set_close_on_exec(fd, argi & FD_CLOEXEC);

Why?

>  	case F_SETSIG:
>  		/* arg == 0 restores default behaviour. */
> -		if (!valid_signal(arg)) {
> +		if (!valid_signal(argi)) {

Why???

>  			break;
>  		}
>  		err = 0;
> -		filp->f_owner.signum = arg;
> +		filp->f_owner.signum = argi;
>  		break;

These two are clearly bogus and I'd like to see more details
on the series rationale, please.
