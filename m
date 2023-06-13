Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862E172E689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbjFMPCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbjFMPCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:02:44 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA5E56;
        Tue, 13 Jun 2023 08:02:42 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-55b38fc0c70so3705834eaf.0;
        Tue, 13 Jun 2023 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686668561; x=1689260561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC1s/K+TNOhamxEwcsY1YmHlsdqeOpQJwmFG5XJ8gPs=;
        b=dXmXkz+/kltcI5skVkB7kccYecEIStCMbhJtQd+Yva077FJMq0XJFBeXn7gvCMDof3
         ERrTeR1M+QfJC5CMzS43fni2Y2FdMFfU8l++3s4G1/0D0Ya74s56LHfBvEVGgt/EMKIB
         fofLWKH+KUfpw5vJW4K3HQq+tNX7++OXH5KGvgsNzUEFYwCp9OcG3zmfGwsq99WOKp7s
         DiqV2i0Kb5Lfup2s5kSgIw0C45awm93vTd8h1hWd0Vt1liBJLNO/ESmbOpa/O4zVkw/q
         YVx7sBftB//1d45eeRpnvU/qtrxpjtnXXfDAypk8CozujL2C0tOabOcSnM0NY+o/unGu
         70yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686668561; x=1689260561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC1s/K+TNOhamxEwcsY1YmHlsdqeOpQJwmFG5XJ8gPs=;
        b=RlzM/o6jrl03wylAshYoEwzYvhJ357sRGId76lUjjB8MAAd2XIwZ/jdr83/67Rdxb4
         997RO9HBjByifiU3+p0Y/xytpfESJNReIiF4OW5tIv+EaKao+IszXsMR0ektJ8knJ8bN
         6gq0bf0vZWZnSZfWIu2U51RHI3liBIvQwXFRXUfUNC6GpWgmCzujaD+KnlycdVE61u5G
         MNxHwvebE+o8NyQVLXtVMpjwEgz6fuk/bBhoaaxTPc9VnEaJL7JMndSyKkJHA7Q8lMk6
         uAXz9ZgfEvRnaFaNNbBMIo7uBKZ/L/f7RmnyVsxcxe2o/cK3PxuPMAhVnD0frN2jz59d
         nPwA==
X-Gm-Message-State: AC+VfDzUAi+HvbiB75Lp/QhZo2hfalc+hL0Lb2YnQWIfiG+7ieC0feD2
        y2w4EywYNhUzjNVI9cLa0phzH6pWRevjDtBLy2Rr8djNrQM=
X-Google-Smtp-Source: ACHHUZ4QQcQTtRNJjj4ts7/wKvVD3E38FC67lCNnfwm87DeaBHG3iTXW6RM2l0/Ui1Cct6m/Uusly80foQPeFd6HC8g=
X-Received: by 2002:a05:6358:e803:b0:129:d3c0:7339 with SMTP id
 gi3-20020a056358e80300b00129d3c07339mr7620219rwb.0.1686668561348; Tue, 13 Jun
 2023 08:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 13 Jun 2023 18:02:30 +0300
Message-ID: <CAOQ4uxgg7dYZFn63CAU4XQoxOTaQQJzUregoyudPxUHgNBpUdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ovl: port to new mount api & updated layer parsing
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 5:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Hey everyone,
>
> /* v3 */
> (1) Add a patch that makes sure that struct ovl_layer starts with a
>     pointer to struct vfsmount as ovl_free_fs() relies on this during
>     cleanup.
> (2) Rebase on top of overlayfs-next brought in substantial rework due to
>     the data layer work. I had to redo a bunch of the parsing and adapt
>     it to the new changes.

Sorry for that pain.
I do like your version much better than mine :)

For the entire series:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> This ports overlayfs to the new mount api and modifies layer parsing to
> allow for additive layer specification via fsconfig().
>
> This passes xfstests including the new data layer lookup work. Here's a
> 500 layer overlayfs mount including a couple of data only layers:
>
> 1094 28 0:48 / /mnt/test rw,relatime shared:214 - overlay none rw,lowerdi=
r=3D/mnt/ovl-lower1:/mnt/ovl-lower2:/mnt/ovl-lower3:/mnt/ovl-lower4:/mnt/ov=
l-lower5:/mnt/ovl-lower6:/mnt/ovl-lower7:/mnt/ovl-lower8:/mnt/ovl-lower9:/m=
nt/ovl-lower10:/mnt/ovl-lower11:/mnt/ovl-lower12:/mnt/ovl-lower13:/mnt/ovl-=
lower14:/mnt/ovl-lower15:/mnt/ovl-lower16:/mnt/ovl-lower17:/mnt/ovl-lower18=
:/mnt/ovl-lower19:/mnt/ovl-lower20:/mnt/ovl-lower21:/mnt/ovl-lower22:/mnt/o=
vl-lower23:/mnt/ovl-lower24:/mnt/ovl-lower25:/mnt/ovl-lower26:/mnt/ovl-lowe=
r27:/mnt/ovl-lower28:/mnt/ovl-lower29:/mnt/ovl-lower30:/mnt/ovl-lower31:/mn=
t/ovl-lower32:/mnt/ovl-lower33:/mnt/ovl-lower34:/mnt/ovl-lower35:/mnt/ovl-l=
ower36:/mnt/ovl-lower37:/mnt/ovl-lower38:/mnt/ovl-lower39:/mnt/ovl-lower40:=
/mnt/ovl-lower41:/mnt/ovl-lower42:/mnt/ovl-lower43:/mnt/ovl-lower44:/mnt/ov=
l-lower45:/mnt/ovl-lower46:/mnt/ovl-lower47:/mnt/ovl-lower48:/mnt/ovl-lower=
49:/mnt/ovl-lower50:/mnt/ovl-lower51:/mnt/ovl-lower52:/mnt/ovl-lower53:/mnt=
/ovl-lower54:/mnt/ovl-lower
>  55:/mnt/ovl-lower56:/mnt/ovl-lower57:/mnt/ovl-lower58:/mnt/ovl-lower59:/=
mnt/ovl-lower60:/mnt/ovl-lower61:/mnt/ovl-lower62:/mnt/ovl-lower63:/mnt/ovl=
-lower64:/mnt/ovl-lower65:/mnt/ovl-lower66:/mnt/ovl-lower67:/mnt/ovl-lower6=
8:/mnt/ovl-lower69:/mnt/ovl-lower70:/mnt/ovl-lower71:/mnt/ovl-lower72:/mnt/=
ovl-lower73:/mnt/ovl-lower74:/mnt/ovl-lower75:/mnt/ovl-lower76:/mnt/ovl-low=
er77:/mnt/ovl-lower78:/mnt/ovl-lower79:/mnt/ovl-lower80:/mnt/ovl-lower81:/m=
nt/ovl-lower82:/mnt/ovl-lower83:/mnt/ovl-lower84:/mnt/ovl-lower85:/mnt/ovl-=
lower86:/mnt/ovl-lower87:/mnt/ovl-lower88:/mnt/ovl-lower89:/mnt/ovl-lower90=
:/mnt/ovl-lower91:/mnt/ovl-lower92:/mnt/ovl-lower93:/mnt/ovl-lower94:/mnt/o=
vl-lower95:/mnt/ovl-lower96:/mnt/ovl-lower97:/mnt/ovl-lower98:/mnt/ovl-lowe=
r99:/mnt/ovl-lower100:/mnt/ovl-lower101:/mnt/ovl-lower102:/mnt/ovl-lower103=
:/mnt/ovl-lower104:/mnt/ovl-lower105:/mnt/ovl-lower106:/mnt/ovl-lower107:/m=
nt/ovl-lower108:/mnt/ovl-lower109:/mnt/ovl-lower110:/mnt/ovl-lower111:/mnt/=
ovl-lower112:/mnt/ovl-low
>  er113:/mnt/ovl-lower114:/mnt/ovl-lower115:/mnt/ovl-lower116:/mnt/ovl-low=
er117:/mnt/ovl-lower118:/mnt/ovl-lower119:/mnt/ovl-lower120:/mnt/ovl-lower1=
21:/mnt/ovl-lower122:/mnt/ovl-lower123:/mnt/ovl-lower124:/mnt/ovl-lower125:=
/mnt/ovl-lower126:/mnt/ovl-lower127:/mnt/ovl-lower128:/mnt/ovl-lower129:/mn=
t/ovl-lower130:/mnt/ovl-lower131:/mnt/ovl-lower132:/mnt/ovl-lower133:/mnt/o=
vl-lower134:/mnt/ovl-lower135:/mnt/ovl-lower136:/mnt/ovl-lower137:/mnt/ovl-=
lower138:/mnt/ovl-lower139:/mnt/ovl-lower140:/mnt/ovl-lower141:/mnt/ovl-low=
er142:/mnt/ovl-lower143:/mnt/ovl-lower144:/mnt/ovl-lower145:/mnt/ovl-lower1=
46:/mnt/ovl-lower147:/mnt/ovl-lower148:/mnt/ovl-lower149:/mnt/ovl-lower150:=
/mnt/ovl-lower151:/mnt/ovl-lower152:/mnt/ovl-lower153:/mnt/ovl-lower154:/mn=
t/ovl-lower155:/mnt/ovl-lower156:/mnt/ovl-lower157:/mnt/ovl-lower158:/mnt/o=
vl-lower159:/mnt/ovl-lower160:/mnt/ovl-lower161:/mnt/ovl-lower162:/mnt/ovl-=
lower163:/mnt/ovl-lower164:/mnt/ovl-lower165:/mnt/ovl-lower166:/mnt/ovl-low=
er167:/mnt/ovl-lower168:/
>  mnt/ovl-lower169:/mnt/ovl-lower170:/mnt/ovl-lower171:/mnt/ovl-lower172:/=
mnt/ovl-lower173:/mnt/ovl-lower174:/mnt/ovl-lower175:/mnt/ovl-lower176:/mnt=
/ovl-lower177:/mnt/ovl-lower178:/mnt/ovl-lower179:/mnt/ovl-lower180:/mnt/ov=
l-lower181:/mnt/ovl-lower182:/mnt/ovl-lower183:/mnt/ovl-lower184:/mnt/ovl-l=
ower185:/mnt/ovl-lower186:/mnt/ovl-lower187:/mnt/ovl-lower188:/mnt/ovl-lowe=
r189:/mnt/ovl-lower190:/mnt/ovl-lower191:/mnt/ovl-lower192:/mnt/ovl-lower19=
3:/mnt/ovl-lower194:/mnt/ovl-lower195:/mnt/ovl-lower196:/mnt/ovl-lower197:/=
mnt/ovl-lower198:/mnt/ovl-lower199:/mnt/ovl-lower200:/mnt/ovl-lower201:/mnt=
/ovl-lower202:/mnt/ovl-lower203:/mnt/ovl-lower204:/mnt/ovl-lower205:/mnt/ov=
l-lower206:/mnt/ovl-lower207:/mnt/ovl-lower208:/mnt/ovl-lower209:/mnt/ovl-l=
ower210:/mnt/ovl-lower211:/mnt/ovl-lower212:/mnt/ovl-lower213:/mnt/ovl-lowe=
r214:/mnt/ovl-lower215:/mnt/ovl-lower216:/mnt/ovl-lower217:/mnt/ovl-lower21=
8:/mnt/ovl-lower219:/mnt/ovl-lower220:/mnt/ovl-lower221:/mnt/ovl-lower222:/=
mnt/ovl-lower223:/mnt/ovl
>  -lower224:/mnt/ovl-lower225:/mnt/ovl-lower226:/mnt/ovl-lower227:/mnt/ovl=
-lower228:/mnt/ovl-lower229:/mnt/ovl-lower230:/mnt/ovl-lower231:/mnt/ovl-lo=
wer232:/mnt/ovl-lower233:/mnt/ovl-lower234:/mnt/ovl-lower235:/mnt/ovl-lower=
236:/mnt/ovl-lower237:/mnt/ovl-lower238:/mnt/ovl-lower239:/mnt/ovl-lower240=
:/mnt/ovl-lower241:/mnt/ovl-lower242:/mnt/ovl-lower243:/mnt/ovl-lower244:/m=
nt/ovl-lower245:/mnt/ovl-lower246:/mnt/ovl-lower247:/mnt/ovl-lower248:/mnt/=
ovl-lower249:/mnt/ovl-lower250:/mnt/ovl-lower251:/mnt/ovl-lower252:/mnt/ovl=
-lower253:/mnt/ovl-lower254:/mnt/ovl-lower255:/mnt/ovl-lower256:/mnt/ovl-lo=
wer257:/mnt/ovl-lower258:/mnt/ovl-lower259:/mnt/ovl-lower260:/mnt/ovl-lower=
261:/mnt/ovl-lower262:/mnt/ovl-lower263:/mnt/ovl-lower264:/mnt/ovl-lower265=
:/mnt/ovl-lower266:/mnt/ovl-lower267:/mnt/ovl-lower268:/mnt/ovl-lower269:/m=
nt/ovl-lower270:/mnt/ovl-lower271:/mnt/ovl-lower272:/mnt/ovl-lower273:/mnt/=
ovl-lower274:/mnt/ovl-lower275:/mnt/ovl-lower276:/mnt/ovl-lower277:/mnt/ovl=
-lower278:/mnt/ovl-lower2
>  79:/mnt/ovl-lower280:/mnt/ovl-lower281:/mnt/ovl-lower282:/mnt/ovl-lower2=
83:/mnt/ovl-lower284:/mnt/ovl-lower285:/mnt/ovl-lower286:/mnt/ovl-lower287:=
/mnt/ovl-lower288:/mnt/ovl-lower289:/mnt/ovl-lower290:/mnt/ovl-lower291:/mn=
t/ovl-lower292:/mnt/ovl-lower293:/mnt/ovl-lower294:/mnt/ovl-lower295:/mnt/o=
vl-lower296:/mnt/ovl-lower297:/mnt/ovl-lower298:/mnt/ovl-lower299:/mnt/ovl-=
lower300:/mnt/ovl-lower301:/mnt/ovl-lower302:/mnt/ovl-lower303:/mnt/ovl-low=
er304:/mnt/ovl-lower305:/mnt/ovl-lower306:/mnt/ovl-lower307:/mnt/ovl-lower3=
08:/mnt/ovl-lower309:/mnt/ovl-lower310:/mnt/ovl-lower311:/mnt/ovl-lower312:=
/mnt/ovl-lower313:/mnt/ovl-lower314:/mnt/ovl-lower315:/mnt/ovl-lower316:/mn=
t/ovl-lower317:/mnt/ovl-lower318:/mnt/ovl-lower319:/mnt/ovl-lower320:/mnt/o=
vl-lower321:/mnt/ovl-lower322:/mnt/ovl-lower323:/mnt/ovl-lower324:/mnt/ovl-=
lower325:/mnt/ovl-lower326:/mnt/ovl-lower327:/mnt/ovl-lower328:/mnt/ovl-low=
er329:/mnt/ovl-lower330:/mnt/ovl-lower331:/mnt/ovl-lower332:/mnt/ovl-lower3=
33:/mnt/ovl-lower334:/mnt
>  /ovl-lower335:/mnt/ovl-lower336:/mnt/ovl-lower337:/mnt/ovl-lower338:/mnt=
/ovl-lower339:/mnt/ovl-lower340:/mnt/ovl-lower341:/mnt/ovl-lower342:/mnt/ov=
l-lower343:/mnt/ovl-lower344:/mnt/ovl-lower345:/mnt/ovl-lower346:/mnt/ovl-l=
ower347:/mnt/ovl-lower348:/mnt/ovl-lower349:/mnt/ovl-lower350:/mnt/ovl-lowe=
r351:/mnt/ovl-lower352:/mnt/ovl-lower353:/mnt/ovl-lower354:/mnt/ovl-lower35=
5:/mnt/ovl-lower356:/mnt/ovl-lower357:/mnt/ovl-lower358:/mnt/ovl-lower359:/=
mnt/ovl-lower360:/mnt/ovl-lower361:/mnt/ovl-lower362:/mnt/ovl-lower363:/mnt=
/ovl-lower364:/mnt/ovl-lower365:/mnt/ovl-lower366:/mnt/ovl-lower367:/mnt/ov=
l-lower368:/mnt/ovl-lower369:/mnt/ovl-lower370:/mnt/ovl-lower371:/mnt/ovl-l=
ower372:/mnt/ovl-lower373:/mnt/ovl-lower374:/mnt/ovl-lower375:/mnt/ovl-lowe=
r376:/mnt/ovl-lower377:/mnt/ovl-lower378:/mnt/ovl-lower379:/mnt/ovl-lower38=
0:/mnt/ovl-lower381:/mnt/ovl-lower382:/mnt/ovl-lower383:/mnt/ovl-lower384:/=
mnt/ovl-lower385:/mnt/ovl-lower386:/mnt/ovl-lower387:/mnt/ovl-lower388:/mnt=
/ovl-lower389:/mnt/ovl-lo
>  wer390:/mnt/ovl-lower391:/mnt/ovl-lower392:/mnt/ovl-lower393:/mnt/ovl-lo=
wer394:/mnt/ovl-lower395:/mnt/ovl-lower396:/mnt/ovl-lower397:/mnt/ovl-lower=
398:/mnt/ovl-lower399:/mnt/ovl-lower400:/mnt/ovl-lower401:/mnt/ovl-lower402=
:/mnt/ovl-lower403:/mnt/ovl-lower404:/mnt/ovl-lower405:/mnt/ovl-lower406:/m=
nt/ovl-lower407:/mnt/ovl-lower408:/mnt/ovl-lower409:/mnt/ovl-lower410:/mnt/=
ovl-lower411:/mnt/ovl-lower412:/mnt/ovl-lower413:/mnt/ovl-lower414:/mnt/ovl=
-lower415:/mnt/ovl-lower416:/mnt/ovl-lower417:/mnt/ovl-lower418:/mnt/ovl-lo=
wer419:/mnt/ovl-lower420:/mnt/ovl-lower421:/mnt/ovl-lower422:/mnt/ovl-lower=
423:/mnt/ovl-lower424:/mnt/ovl-lower425:/mnt/ovl-lower426:/mnt/ovl-lower427=
:/mnt/ovl-lower428:/mnt/ovl-lower429:/mnt/ovl-lower430:/mnt/ovl-lower431:/m=
nt/ovl-lower432:/mnt/ovl-lower433:/mnt/ovl-lower434:/mnt/ovl-lower435:/mnt/=
ovl-lower436:/mnt/ovl-lower437:/mnt/ovl-lower438:/mnt/ovl-lower439:/mnt/ovl=
-lower440:/mnt/ovl-lower441:/mnt/ovl-lower442:/mnt/ovl-lower443:/mnt/ovl-lo=
wer444:/mnt/ovl-lower445:
>  /mnt/ovl-lower446:/mnt/ovl-lower447:/mnt/ovl-lower448:/mnt/ovl-lower449:=
/mnt/ovl-lower450:/mnt/ovl-lower451:/mnt/ovl-lower452:/mnt/ovl-lower453:/mn=
t/ovl-lower454:/mnt/ovl-lower455:/mnt/ovl-lower456:/mnt/ovl-lower457:/mnt/o=
vl-lower458:/mnt/ovl-lower459:/mnt/ovl-lower460:/mnt/ovl-lower461:/mnt/ovl-=
lower462:/mnt/ovl-lower463:/mnt/ovl-lower464:/mnt/ovl-lower465:/mnt/ovl-low=
er466:/mnt/ovl-lower467:/mnt/ovl-lower468:/mnt/ovl-lower469:/mnt/ovl-lower4=
70:/mnt/ovl-lower471:/mnt/ovl-lower472:/mnt/ovl-lower473:/mnt/ovl-lower474:=
/mnt/ovl-lower475:/mnt/ovl-lower476:/mnt/ovl-lower477:/mnt/ovl-lower478:/mn=
t/ovl-lower479:/mnt/ovl-lower480:/mnt/ovl-lower481:/mnt/ovl-lower482:/mnt/o=
vl-lower483:/mnt/ovl-lower484:/mnt/ovl-lower485:/mnt/ovl-lower486:/mnt/ovl-=
lower487:/mnt/ovl-lower488:/mnt/ovl-lower489:/mnt/ovl-lower490:/mnt/ovl-low=
er491:/mnt/ovl-lower492:/mnt/ovl-lower493:/mnt/ovl-lower494:/mnt/ovl-lower4=
95:/mnt/ovl-lower496::/mnt/ovl-lower497::/mnt/ovl-lower498::/mnt/ovl-lower4=
99::/mnt/ovl-lower500,upp
>  erdir=3D/mnt/ovl-upper,workdir=3D/mnt/ovl-work,redirect_dir=3Don,index=
=3Don,metacopy=3Don
>
> Christian
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v3:
> - Fix potential NULL deref in ovl_init_fs_context().
> - Don't create one long mount option string for lowerdir. Just use
>   seq_printf() to create it on demand.
> - Link to v2: https://lore.kernel.org/r/20230605-fs-overlayfs-mount_api-v=
2-0-3da91c97e0c0@kernel.org
>
> Changes in v2:
> - Split into two patches. First patch ports to new mount api without chan=
ging
>   layer parsing. Second patch implements new layer parsing.
> - Move layer parsing into a separate file.
> - Link to v1: https://lore.kernel.org/r/20230605-fs-overlayfs-mount_api-v=
1-1-a8d78c3fbeaf@kernel.org
>
> ---
>
>
>
> ---
> base-commit: f777c8266c1230fa44de7261b61a13d787b27f44
> change-id: 20230605-fs-overlayfs-mount_api-20ea8b04eff4
>
