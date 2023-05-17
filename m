Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F072706855
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEQMji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 08:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjEQMjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 08:39:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0B1FFA
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 05:39:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34HCdE3j020485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684327157; bh=zB3NDRPxq6MYoxevq1HGj40hrXlXLj7oBFmH79jVKps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WWgyH7CULPNoM2VYokIIWTxWmj9cbi81gKXBKYw7kMUIQN3TYy4vOLxrFbi1XfXR3
         HwMdUFEWdel6hZawKtdWpO9qz7W9RXJaxFddb24VKKmM97rmUMckzzOGuaBSRWxBQI
         ixlHhzpOnH2HvRqtMzIV4QAsKy7pBlOquo3MhmC454u8zDPNgtI28H+etJlTCJXaEd
         Pz39tqrOe7Bh0qKRQA22g6LH/4IOwhNgWLAczpirprViUL9UoMPZcj5GqDcilTdPUQ
         qRTGOgCTsCX9TX/8TzeB45MCP4Kax2JBf87OUzSPwEZoEnrjezRxIS0QmWfzzFQ6Uf
         1qyAJuh3Juq4A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9D1DD15C0529; Wed, 17 May 2023 08:39:14 -0400 (EDT)
Date:   Wed, 17 May 2023 08:39:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
Message-ID: <20230517123914.GA4578@mit.edu>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
 <20230517-herstellen-zitat-21eeccd36558@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-herstellen-zitat-21eeccd36558@brauner>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 09:42:59AM +0200, Christian Brauner wrote:
> 
> I have no idea about the original flame war that ended RichACLs in
> additition to having no clear clue what RichACLs are supposed to
> achieve. My current knowledge extends to "Christoph didn't like them".

As to what RichACL's are supposed to achieve....

Windows/NFSv4 -style ACL's are very different from POSIX semantics, in
a gazillion ways.  For example, if you set a top-level acl, it will
automatically affect all of the ACL's in the subhierarcy.  This is
trivially easy in Windows given that apparently ACL's are evaluated by
path every time you try to operate on a file (or at least, that's how
it works effectively; having not taken a look at Windows source code,
I can't vouch for how it is actually implemented.)  This is, of
course, a performance disaster and doesn't work all that well for
Linux where we can do things like like fchdir() and use O_PATH file
descriptors and *at() system calls.  Moreover, Windows doesn't have
things like the mode parameter to open(2) and mkdir(2) system calls.

As a result, RichACL's are quite a bit more complicated than Posix
ACL's or the Windows-style ACL's from which they were derived because
they have to compromise between the Windows authorization model and
the Posix/Linux authorization model while being expressive enough
to mostly emulate Windows-style ACL's.  For example, instead of
implementing Windows-style "automatic inheritance", setrichacl(1) will
do the moral equivalent of chmod -R, and then add a lot of hair in the
form of "file_inherit, dir_inherit, no_propagate, and inherit_only"
flags to each ACL entry, which are all there to try to mostly (but not
completely) handle make Windows-style and Linux/POSIX acl's work
within the same file system.  There's a lot more detail of the hair
documented here[1].

[1] https://www.systutorials.com/docs/linux/man/7-richacl/

I'll note most of this complexity is only necessary if you want to
have local file access to the file system work with similar semantics
as what would get exported via NFSv4.  If you didn't, you could just
store the Windows-style ACL in an xattr and just let it be set via the
remote file system, and return it when the remote file system queries
it.  The problem comes when you want to have "RichACLs" actually
influence the local Linux permissions check.

Personally, I think this is rarely needed, since (a) most people
implementing a Windows-style filer for Windows client are doing so on
a dedicated file server, and local access to the exported files are
rarely needed.  Secondly, (b) Windows-style access need to be
expressed in terms of Windows-style Security ID's for large complex
enterprise deployment where you have nested Windows-style domains, and
how you map a 128+ bit Windows SID to a local Unix UID is a previously
unsolved problem.

So it's a pretty rare niche use case, and *I've* never thought that
this is all that important.  On the other hand, for those people who
believe that "This is the year of the Linux Desktop", and who might
want to export their local Linux directories on their Desktop to a set
of peer Windows clients, and who are using complex Windows-style ACL's
(but not *too* complex such that they have nested domain identifiers),
then RichACL's might be just the ticket.  Furthermore, RichACL's are
apparently an out-of-tree patch maintained by some distros in their
distro kernel, so maybe they know something I don't.

Add to that the issues of the implementation level concerns which
Cristoph has already described, and it's really not all that
surprising that the progress on the patchset kind of stalled....

	   	    	     	    - Ted
