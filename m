Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD71E6E235D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDNMee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjDNMec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE011C;
        Fri, 14 Apr 2023 05:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABDC64782;
        Fri, 14 Apr 2023 12:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0E2C433EF;
        Fri, 14 Apr 2023 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475668;
        bh=BAKGgus4eGkCvEXO27Qe9/ouyyrTGRg0jGngNGSPXuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lr4CGPoxIPNfWbGXJglt4wgpskvaHOjGHLzfGWujsfLtMTduRUay1tU7R2/fHeBMx
         7qLHJcGb/WExdG8Z9iveMTz1kgxl2iuHRYePQpqbba7WpcQPw1Unl6YuYZzzTVGD+s
         jcfrUJteyFGzNwlVVa6yYDnaHLsi79JBt6hDNCTA1a/E3QbSRYKOqtHvBStwW1HazD
         S92BWOxtbV2NPtDQalMIcprDQsksn4fyCBrcY2lqOjYsSboHD9xR4vOWfAJTew+lJX
         BHeaI4c28CWHJLre+g+eq17q5ngGVhrC24gi8l3BNxzrJLDk48TAiRADvlzim5NbVy
         o1aJODexSzC3w==
Date:   Fri, 14 Apr 2023 14:34:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        linux-kernel@vger.kernel.org,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 5/5] dnotify: Pass argument of fcntl_dirnotify as int
Message-ID: <20230414-vorgibt-kringeln-f8bf1ae5278e@brauner>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
 <20230414100212.766118-6-Luca.Vizzarro@arm.com>
 <20230414104625.gyzuswldwil4jlfw@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414104625.gyzuswldwil4jlfw@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 12:46:25PM +0200, Jan Kara wrote:
> On Fri 14-04-23 11:02:12, Luca Vizzarro wrote:
> > The interface for fcntl expects the argument passed for the command
> > F_DIRNOTIFY to be of type int. The current code wrongly treats it as
> > a long. In order to avoid access to undefined bits, we should explicitly
> > cast the argument to int.
> > 
> > Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
> > Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: David Laight <David.Laight@ACULAB.com>
> > Cc: Mark Rutland <Mark.Rutland@arm.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
> 
> Looks good to me. Do you plan to merge this series together (perhaps
> Christian could?) or should I pick up the dnotify patch? In case someone
> else will merge the patch feel free to add:
> 
> Acked-by: Jan Kara <jack@suse.cz>

Yeah, I'm happy to carry it once it's reviewed if noone objects.
