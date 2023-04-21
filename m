Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C56EA211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 05:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjDUDA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 23:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjDUDAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:00:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BE10EC;
        Thu, 20 Apr 2023 20:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=//YIhm6gzARI8o6MnvvcCv8dn1240DofB0ntD6C9IRA=; b=fc6Vr5SKLpsamAaUeQFF3+4Vt/
        N05OljI+CgfOjikJDcdsOnE3IewxzXycsEkVOCxv2x38T7AdReqlDiAU6MvkUlZ1bpaHrziaSj0fL
        iEzLAuXoaSqIPbCE4oLA1eqI1Tdd/591vBiRJ3uAvpi0cS6otTzMxl99GqqV0EeDxWIsJvtihY4Nn
        1WAG/onN9Tr5LJcnw46JFh3PJJaiaeFiMVXTfi2/2vMDR6JRUjBB3EmCCcAWEts9w+ey3+zibNUPu
        mvh7yZmCBTZ/eZNFfPFAEL8WSs+qqOyaqPJlsD6Z5F/+5AAA8Fuq5HlMqCUfyKoA0LU3ikTrSPyJT
        DZ3ckHGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pph0T-00B3bY-2A;
        Fri, 21 Apr 2023 03:00:17 +0000
Date:   Fri, 21 Apr 2023 04:00:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "cc: Greg KH" <gregkh@linuxfoundation.org>, security@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: Patch for a overwriting/corruption of the file system
Message-ID: <20230421030017.GA3390869@ZenIV>
References: <CADZg-m0Z+dOGfG=ddJxqPvgFwG0+OLAyP157SNzj6R6J2p7L-g@mail.gmail.com>
 <ZA734rBwf4ib2u9n@kroah.com>
 <CADZg-m04XELrO-v-uYZ4PyYHXVPX35dgWbCHBpZvwepS4XV9Ew@mail.gmail.com>
 <CADZg-m2k_L8-byX0WKYw5Cj1JPPhxk3HCBexpqPtZvcLRNY8Ug@mail.gmail.com>
 <ZA77qAuaTVCEwqHc@kroah.com>
 <20230314095539.zf7uy27cjflqp6kp@wittgenstein>
 <20230314165708.GY3390869@ZenIV>
 <20230314171327.k6krhiql3d7tpqat@wittgenstein>
 <CADZg-m3w_xJ3cQS=+-yb7iS5PJg8kGHntMb7poP6tOsOXvnDeQ@mail.gmail.com>
 <CADZg-m1uBXit9gX0bcZQ3vWvg34J_sLX-df32x+JX=bjtJeg0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADZg-m1uBXit9gX0bcZQ3vWvg34J_sLX-df32x+JX=bjtJeg0w@mail.gmail.com>
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

On Wed, Mar 15, 2023 at 02:33:48PM +0530, Kirtikumar Anandrao Ramchandani wrote:
> While I am going through the code at the moment, I think there is one more
> issue. It probably can't just compare "old_dir" and "new_dir", since those
> are just pointers to structs. So, both addresses can be completely
> different, and still represent the same folder, yes?

No, they can not.  We should never have different in-core instances of
struct inode representing the same on-disk object - otherwise all locking
goes to hell, for example.
