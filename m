Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064845E879D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 04:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiIXCua (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiIXCu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:50:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE4B516D;
        Fri, 23 Sep 2022 19:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QX2RydskezkFReMmxeS776t8RU+t/KjVgluk/NS4nY0=; b=aPlaqrO/HrDpICO1XvMwqa2/RW
        kNkC/nxKyL0cPvTJ+5aZtS2ZKMzbLkS6tIecwXv5gblUBtSdAZtsUS9j37QQjsnnsZJgoM6hd8RUo
        U9zYevr2ivv5zuka/DYkynpiERcGFmem5gk3v79S4EEFMQ6Uf4hvcuPhyXMIKMk9n4ZFWEVqc8exq
        8OFyXN6zz4LSajGliDnu9uBQv0oY01Cy6V94nRGRisBuhm5UJ3l4Lk073daTKW3B0DxW7Jca4+Kta
        du7B16Zaa5K9Kcc26xrAWTGJRzq2j4OZYaNiXvnea8Lor5S26o30kaJCamyYySI7zmIlqBKt/pnKY
        UjhjuxMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obvFD-0037d1-34;
        Sat, 24 Sep 2022 02:50:20 +0000
Date:   Sat, 24 Sep 2022 03:50:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] cifs: Add a function to read into an iter from a
 socket
Message-ID: <Yy5wa7MAmb7AkoPa@ZenIV>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
 <166126395495.708021.12328677373159554478.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166126395495.708021.12328677373159554478.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:12:34PM +0100, David Howells wrote:
> +int
> +cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter,
> +			   unsigned int to_read)
> +{
> +	struct msghdr smb_msg;
> +	int ret;
> +
> +	smb_msg.msg_iter = *iter;

> +	if (smb_msg.msg_iter.count > to_read)
> +		smb_msg.msg_iter.count = to_read;

ITYM
	iov_iter_truncate(&smb_msg.msg_iter, to_read);

> +	ret = cifs_readv_from_socket(server, &smb_msg);
> +	if (ret > 0)
> +		iov_iter_advance(iter, ret);
> +	return ret;
> +}
> +
>  static bool
>  is_smb_response(struct TCP_Server_Info *server, unsigned char type)
>  {
> 
> 
