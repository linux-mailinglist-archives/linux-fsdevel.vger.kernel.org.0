Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9606C67C726
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjAZJ1I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjAZJ1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:27:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B433E8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:27:05 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-318-koHdLQDNPsa4DU4YcOx9dg-1; Thu, 26 Jan 2023 09:27:03 +0000
X-MC-Unique: koHdLQDNPsa4DU4YcOx9dg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 26 Jan
 2023 09:27:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 26 Jan 2023 09:27:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        "Tom Talpey" <tom@talpey.com>, Stefan Metzmacher <metze@samba.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>
Subject: RE: [RFC 08/13] cifs: Add a function to read into an iter from a
 socket
Thread-Topic: [RFC 08/13] cifs: Add a function to read into an iter from a
 socket
Thread-Index: AQHZMQai4Pp239USek2HtsrL1M/WuK6wa3Ew
Date:   Thu, 26 Jan 2023 09:27:02 +0000
Message-ID: <0d53a3cc9f9448298bba04d06f51b23d@AcuMS.aculab.com>
References: <20230125214543.2337639-1-dhowells@redhat.com>
 <20230125214543.2337639-9-dhowells@redhat.com>
In-Reply-To: <20230125214543.2337639-9-dhowells@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: 25 January 2023 21:46

> Add a helper function to read data from a socket into the given iterator.
...
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
> +	ret = cifs_readv_from_socket(server, &smb_msg);
> +	if (ret > 0)
> +		iov_iter_advance(iter, ret);
> +	return ret;
> +}

On the face of it that passes a largely uninitialised 'struct msghdr'
to cifs_readv_from_socket() in order to pass an iov_iter.
That seems to be asking for trouble.

I'm also not 100% sure that taking a copy of an iov_iter is a good idea.

If cifs_readv_from_socket() only needs the iov_iter then wouldn't
it be better to do the wrapper the other way around?
(Probably as an inline function)
Something like:

int
cifs_readv_from_socket(struct TCP_Server_Info *server, struct msghdr *smb_msg)
{
	return cifs_read_iter_from_socket(server, &smb_msg->msg_iter, smb_msg->msg_iter.count);
}

and then changing cifs_readv_from_socket() to just use the iov_iter.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

