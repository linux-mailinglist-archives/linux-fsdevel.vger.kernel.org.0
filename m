Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7D6EA220
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 05:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDUDFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 23:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDUDFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:05:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB5E7;
        Thu, 20 Apr 2023 20:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qZbcj19slFDbMIy7RXzfKd/r5mkJkxlZkvu1IBtutOQ=; b=hJ0VzRvDcFm/73MWhrHPxGsj0r
        Gn4B26iBzKXnWKHdUZNKASOe9Zmc7F6eNE3ZTWGfnWl68wKYKWDCdQcf1SI22YXKg6dwrYZuHUs3W
        xJeVdjhQDg2/1qXVrDqBulR1kRrIwueTNBHcRRQcJNTz7DxLy/RzXqNg26RIIoi5jXXI8ZlcwPvSc
        I6d0XygaXtZfpp2UEpuXavtlOBVjh1ow7pIuYamIoTQwg60jdCks4hHtqb6Y4SkiKQME1MBfcMhLo
        uCbCu5VU0qAj42vxVvXR6YAmbRaQw6SLjc13MeR83Qy4uNjCjDOqe1bjE4ypxWkYyxqzIN8T8c7BP
        Xb2Aq+zw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pph5W-00B3hz-1a;
        Fri, 21 Apr 2023 03:05:30 +0000
Date:   Fri, 21 Apr 2023 04:05:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "cc: Greg KH" <gregkh@linuxfoundation.org>, security@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Patch for a overwriting/corruption of the file system
Message-ID: <20230421030530.GB3390869@ZenIV>
References: <ZA734rBwf4ib2u9n@kroah.com>
 <CADZg-m04XELrO-v-uYZ4PyYHXVPX35dgWbCHBpZvwepS4XV9Ew@mail.gmail.com>
 <CADZg-m2k_L8-byX0WKYw5Cj1JPPhxk3HCBexpqPtZvcLRNY8Ug@mail.gmail.com>
 <ZA77qAuaTVCEwqHc@kroah.com>
 <20230314095539.zf7uy27cjflqp6kp@wittgenstein>
 <20230314165708.GY3390869@ZenIV>
 <20230314171327.k6krhiql3d7tpqat@wittgenstein>
 <CADZg-m3w_xJ3cQS=+-yb7iS5PJg8kGHntMb7poP6tOsOXvnDeQ@mail.gmail.com>
 <CADZg-m1uBXit9gX0bcZQ3vWvg34J_sLX-df32x+JX=bjtJeg0w@mail.gmail.com>
 <20230421030017.GA3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421030017.GA3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 04:00:17AM +0100, Al Viro wrote:
> On Wed, Mar 15, 2023 at 02:33:48PM +0530, Kirtikumar Anandrao Ramchandani wrote:
> > While I am going through the code at the moment, I think there is one more
> > issue. It probably can't just compare "old_dir" and "new_dir", since those
> > are just pointers to structs. So, both addresses can be completely
> > different, and still represent the same folder, yes?
> 
> No, they can not.  We should never have different in-core instances of
> struct inode representing the same on-disk object - otherwise all locking
> goes to hell, for example.

... and we should never, ever have two dentries aliasing the same directory
inode, so d_inode() part is also not needed and actively confusing,
since anyone running into it is likely to go "Why is it written that way?
What is it protecting against?  Where does <such and such code> protect
itself against the same situation?".  And there's a _lot_ of code that
would break horribly if we ever run into such.

Defensive programming can be harmful...
