Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2F67C750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbjAZJaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbjAZJaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:30:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C811653
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674725355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q00Xxn1cD6lPjr/aMO9QR9HG5kM9NAzpDCX3OBr9UoI=;
        b=F8mMIOehRI+vg86xz9xXtnwa8LjfrLW9g1eM+H/x+DANcFZVgsJtZxwIfwowJEuNEwJBlZ
        Cct8pBj6iHO1s8CNGpvzxs5fqERSVnwxTgboC5n2GlFM0j+1s4tc5VnEGvafIEkCkGyDxp
        7yogqnJw1V3q4RW0g+BrNUWXCS1nARw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-136-hQk24V_COPOU1KtvM4ug0Q-1; Thu, 26 Jan 2023 04:29:14 -0500
X-MC-Unique: hQk24V_COPOU1KtvM4ug0Q-1
Received: by mail-wm1-f72.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso756132wms.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q00Xxn1cD6lPjr/aMO9QR9HG5kM9NAzpDCX3OBr9UoI=;
        b=LLbj3uxkoayotAXJFc3LQMNU9FjLj6tCTlzWUaE37ag35ki3+5yBPZu23uzARXWR2L
         dY24it07vCaWfGUUYdhqZp5LlYc9ibMm79KLWOEj5b0xMmUVGNpah+A8s6ieTEa4izdz
         l2rPCoNUKL9Z1bvXnVwTWKu+xwKQoIUYp3oNnH7Z2lxaDynGrpxESesJcu5QNUKAg0lc
         RXo0qZn/fIcp86SNPjMCiWBxGGBdTzj+M/CCLrX2QyOQXad6sUqc0iHlTW8964uivmFK
         S/PpqnBmqnFcchWIarAfVjA/wsI/kgPNqNlGvhQ4OsZWolZ7o79DzPPpbfaGzX6AwQV7
         JQSA==
X-Gm-Message-State: AFqh2ko3y9yh2tL85O5LeVV7fbP6jpsO5BN1nLCqVDL8pWCFm4WFIK6J
        0f45rFS5SqNG7z4PLS9AtH9JujS9ZidAynCP+ItOT6cI7RDr2USTZn1ctnz/9ti0NsicS1iGCDl
        zCgCo4sARSEse6un5eO5VHYFLGw==
X-Received: by 2002:a05:600c:4e8d:b0:3dc:b0e:1e44 with SMTP id f13-20020a05600c4e8d00b003dc0b0e1e44mr11275474wmq.4.1674725352857;
        Thu, 26 Jan 2023 01:29:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv4iuwtS6MVzNeCsO8laxeJMePaZ53o6qYn4WQWThNpjBtIStUKxwcRZto1e+4onhQznqLkkA==
X-Received: by 2002:a05:600c:4e8d:b0:3dc:b0e:1e44 with SMTP id f13-20020a05600c4e8d00b003dc0b0e1e44mr11275458wmq.4.1674725352592;
        Thu, 26 Jan 2023 01:29:12 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003cffd3c3d6csm923358wmo.12.2023.01.26.01.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:29:12 -0800 (PST)
Message-ID: <db0c8f98-4bc1-a3ee-e173-7960830b1d3c@redhat.com>
Date:   Thu, 26 Jan 2023 10:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 6/8] block: Add BIO_PAGE_PINNED and associated
 infrastructure
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-7-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230125210657.2335748-7-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25.01.23 22:06, David Howells wrote:
> Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> (FOLL_PIN) and that the pin will need removing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

